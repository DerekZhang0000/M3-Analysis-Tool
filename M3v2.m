timesStr = "90, 120, 111, 132, 107, 98, 89, 96, 105";
scoresStr = "2.71, 2.88, 2.99, 2.74, 2.36, 2.78, 3, 2.97, 2.93";

knownComboStr = "23, 132, 2.74";

function inverseList = inverse(list)
% Turns a list of numbers into a list of their inverses
    inverseList = zeros(1, length(list));
    for i = 1:length(list)
        inverseList(i) = 1 / list(i);
    end
end

function cellArr = addUnique(cellArr, element)
% Adds an element into a cell array if it is not already present
    present = any(cellfun(@(c) isequal(c, new_pair), cell_array));
    if ~present
        cellArr{end + 1} = element;
    end
end

function numList = strToNums(str)
% Turns a comma-seperated string of numbers into a list of doubles
    numStrs = split(str, ",");
    numList = str2double(numStrs);
end

function pairList = pair(list1, list2)
%   Turns 2 lists into 1 list of index pairs
%   e.g. pair([1, 2, 3], [4, 5, 6]) = {[1, 4], [2, 5], [3, 6]}
    if ~isvector(list1) || ~isvector(list2) || numel(list1) ~= numel(list2)
        error("Inputs must be vectors of the same length");
    end
    
    pairList = cell(1, length(list1));
    for i = 1:length(list1)
        pairList{i} = [list1(i), list2(i)];
    end
end

function inferredList = inferLenfths(timeScoreList, knownCombo)
%   Returns a list of inferred antenna lengths
%   Input should be a list of time-score pairs and a known
%   length-time-score combo
    if ~isvector(knownCombo) || numel(knownCombo) ~= 3
        error("Invalid known variable(s)")
    end

    knownLength = knownCombo(1);
    knownTime = knownCombo(2);
    knownScore = knownCombo(3);

    inferredList = zeros(1, length(timeScoreList));
    for i = 1:length(timeScoreList)
        tempPair = timeScoreList{i};
        tempTime = tempPair(1);
        tempScore = tempPair(2);
        tempLength = (tempScore - 2) / (knownScore - 2) * (knownLength / knownTime) * tempTime;
        inferredList(i) = tempLength;
    end
end

