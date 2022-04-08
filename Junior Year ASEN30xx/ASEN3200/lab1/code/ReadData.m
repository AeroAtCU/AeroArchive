function Data = ReadData(files)
    fileNum = numel(files);
    for i = 1 : fileNum
        name = files(i).name;
        Data.(name) = readtable(files(i).name);
    end
end