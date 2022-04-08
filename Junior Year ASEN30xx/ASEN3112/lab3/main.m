% main
close all

%figure; title("Vibration Response (Tail)");
%xlabel("Input Frequency [mm/s^2]"); ylabel("Response Frequency [mm/s^2]");
%plot(Lab3Data(:,1), Lab3Data(:,2));

% sin -> remove neg
% lineear -> can normalize
fft_data = real(fft(Lab3Data));

% construct array of maximums
maxes = nan(1,length(fft_data(1,:)));
for i = 1:length(fft_data(1,:)), maxes(i) = max(fft_data(:,i)); end

% normalize array and format input hz
data_norm = fft_data ./ maxes;
data_norm(data_norm<0) = nan;
data_norm(:,2) = data_norm(:,2) * 8 + 2;

% plot
figure; title("Vibration Response Using FFT of Acceleration"); hold on;
xlabel("Input Frequency [hz]"); ylabel("Normalized Response Frequency [hz]");
 
plot(data_norm(:,2), data_norm(:,4), 'g.', 'MarkerSize', 15)
plot(data_norm(:,2), data_norm(:,5), 'b.', 'MarkerSize', 15)
plot(data_norm(:,2), data_norm(:,3), 'r.', 'MarkerSize', 15)
legend('Nose', 'Wing', 'Tail');


figure; title("Vibration Response Using FFT of Displacement"); hold on;
xlabel("Input Frequency [hz]"); ylabel("Response Frequency [hz]");
plot(data_norm(:,6), data_norm(:,7), 'r.', 'MarkerSize', 15)
plot(data_norm(:,6), data_norm(:,8), 'g.', 'MarkerSize', 15)
plot(data_norm(:,6), data_norm(:,9), 'b.', 'MarkerSize', 15)
legend('Tail', 'Nose', 'Wing');


%for i = 3:5
%    plot(data_norm(:,2), data_norm(:,i), '.-');
%end
%legend;


%%
%input = Lab3Data(:,2) ./ Lab3Data(:,6);
data = abs(Lab3Data * 1000); % Convert all to m
%inputfreq = sqrt(abs(Lab3Data(:,2)) ./ abs(Lab3Data(:,6))) ./ (2*pi);
inputfreq = sqrt(1 .* data(:,2) ./ (2 * pi^2 .* data(:,6)));

figure; hold on;
plot(Lab3Data(:,1), inputfreq)

% 0.39s time step

%%

data = Lab3Data;
%data(data<0) = NaN;
data = abs(data);

%%



