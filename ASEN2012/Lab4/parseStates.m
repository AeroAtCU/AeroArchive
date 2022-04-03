function results = parseStates(inputStruct, endPos)
    % split array into struct. For shortening code and ensuring  a consistent
    % convention.
	inputStruct.pos.x = inputStruct.results(1:endPos,1);
	inputStruct.pos.y = inputStruct.results(1:endPos,3);
	inputStruct.vel.x = inputStruct.results(1:endPos,2);
	inputStruct.vel.y = inputStruct.results(1:endPos,4);
	inputStruct.tData = inputStruct.tData(1:endPos);
	results = inputStruct;
end
