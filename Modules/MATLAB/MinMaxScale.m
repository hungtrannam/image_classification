function MinMax = MinMaxScale(Data, var)
    MinMax = [];
    sz = size(Data);
    for i = 1:var
        for j = 1:length(Data)
        MinMax(j, i) = (Data(j, i)-min(Data(:, i))) / (max(Data(:, i))-min(Data(:, i)));
    end
    fprintf('Data has been stadarded.\n')
end
