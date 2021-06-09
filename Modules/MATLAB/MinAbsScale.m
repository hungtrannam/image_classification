function MinAbs = MinAbsScale(Data)
    MinAbs = [];
    sz = size(Data);
    for i = 1:sz(1,2)
        s(:, i) = Data(:, i);
        d(i) = max(s(:, i));
        MinAbs(:, i) = s(:, i)./d(i);
    end
    fprintf('Data has been stadarded.\n')
end
