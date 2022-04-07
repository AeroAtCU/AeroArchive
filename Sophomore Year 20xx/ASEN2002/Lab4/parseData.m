function AOA = parseData()
% Parse data into one large but more useful struct.
% This started out simple but got unnecessarily complex as the deadline
% approached. 

files = dir('AirfoilPressureData_S013');

% Declare constants
velocities = ["v_9"; "v_17"; "v_34"];

for i= 3:size(files) % loop through each file
    % (Using previously written filename code by someone else)
    Input = struct2cell(files(i));
    Input = Input{1};
    Input = strcat('AirfoilPressureData_S013/', Input);
    Input = load(Input);
    for j  = 0:3 % Loop through each AOA (3 AOA per group, 1 group per file)
        
        if Input(j*60+1,23) < 0
            aoaname = strcat('aoa_neg',num2str(abs(Input((j*60+1),23))));
        else
            aoaname = strcat('aoa_pos',num2str(Input((j*60+1),23)));
        end
        
        AOA.(aoaname).pitot_dyn = Input((j*60+1):((j+1)*60),5);
        AOA.(aoaname).AOA = Input((j*60+1):((j+1)*60),23);
        AOA.(aoaname).norm_F = Input((j*60+1):((j+1)*60),24);
        AOA.(aoaname).axial_F = Input((j*60+1):((j+1)*60),25);
        AOA.(aoaname).pitching_M = Input((j*60+1):((j+1)*60),26);
        AOA.(aoaname).ELD_X = Input((j*60+1):((j+1)*60),27);
        AOA.(aoaname).ELD_Y = Input((j*60+1):((j+1)*60),28);
        
        for m = 1:3 % Loop through each velocity (3 V per AOA)
            vname = velocities{m};

            for k = 7:23 % Loop through each port (16 real and one theoretical port per V)
                pname = strcat('p',num2str(k-6));
                
                % If on port 11, set to nan and make next ports to use row-1 data
                if ((k-6)==11), p_vals = nan(60,1);
                elseif ((k-6)<11), p_vals = Input((j*60+1):((j+1)*60),k);
                elseif ((k-6)>11), p_vals = Input((j*60+1):((j+1)*60),k-1);
                else, warning('Something went wrong (parseData.m');
                end
                
                AOA.(aoaname).(vname).(pname) = p_vals(((m-1)*20 + 1):(m*20));
            end
            
            AOA.(aoaname).(vname) = extrapPort11(AOA.(aoaname).(vname));
            
            for k = 1:17 % Loop through each port again to calculate cp (seperate b/c need calculated p11)
                pname = strcat('p',num2str(k));
                cpname = strcat('cp',num2str(k));
                
                AOA.(aoaname).(vname).(cpname) = AOA.(aoaname).(vname).(pname) ./ AOA.(aoaname).pitot_dyn(((m-1)*20 + 1):(m*20));
            end
        end
    end
end
end