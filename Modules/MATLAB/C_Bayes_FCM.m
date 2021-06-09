%Khai bao du lieu 
TrainData = [glcmtraindata(1:200, 1) glcmtraindata(1:200, 2) glcmtraindata(1:200, 3) glcmtraindata(1:200, 4) glcmtraindata(1:200, 5)];
Train_X = [glcmtraindata(1:200, 1) glcmtraindata(1:200, 2) glcmtraindata(1:200, 3) glcmtraindata(1:200, 4)];
Train_Y = TrainData(:, end) + 1;

% Standard via Min-Max Scale
StandardData = MinMaxScale(TrainData, 4);

TrainData = [StandardData Train_Y];

Test1 = 0:.2:1;
Test2 = 0:.2:1;
Test3 = 0:.2:1;
Test4 = 0:.2:1;

TestData = [];

for i = 1:length(Test1)
    for j = 1:length(Test2)
        for k = 1:length(Test3)
            for h = 1:length(Test4)
                TestData = [TestData; Test1(1, i) Test2(1, j) Test3(1, k) Test4(1, h)]; 
            end
        end
    end
end
TestData;


% Fuzzy Cluster Method
prior = [];
for g = 1:length(TestData)
    Z = TrainData';
    Z = Z(1:end-1,:);
    pt = TestData(g,:);
    pt = pt';
    Z = [Z pt];
    
    U = [];
    for i = 1:length(TrainData)
        for j = 1:2
            if TrainData(i,end) == j
                U(j, i) = 1;
            end
        end
    end
    U_add = [.5; .5];
    U = [U U_add];
    
    szZ = size(Z);
    szU = size(U);
    for k = 1:szZ(1,1)
        for i = 1:szU(1,1)
            numerator=0; 
            denomirator=0;
            for j = 1:length(Z)
                numerator = numerator + (U(i, j).^2) * Z(k, j);
                denomirator = denomirator + U(i, j).^2;
            end
            v(k, i)=numerator/denomirator;
        end
    end
    v;
    
    for j = 1:length(Z)
        for i = 1:szU(1,1)
            d2(i, j) = 0;
            for k = 1:szZ(1, 1)
                d2(i, j) = d2(i, j) + (v(k, i) - Z(k, j)).^2;
            end
        end
    end
    d2;

    for j = 1:length(Z)
        m = 0;
        for k = 1:szU(1,1)
            if d2(k, j) == 0
                m = m + 1;
            end
        end
        if m == 0            
            for i = 1:szU(1,1)
                Sum = 0;
                for k = 1:szU(1,1)
                    Sum = Sum + (d2(i, j)/d2(k, j));
                end
                U_new(i, j) = 1/Sum;
            end
        else
            for l = 1:szU(1, 1)
                if d2(l, j) == 0
                    U_new(l,j) = 1/m;
                else
                    U_new(l, j) = 0;
                end
            end
        end
    end
    U_new;

    L1 = 0;
    for i = 1:szU(1,1)
        for j = 1:length(Z)
            dist(i, j) = abs(U_new(i, j) - U(i, j));
            if dist(i, j) > L1
                L1 = dist(i, j);
            end
        end
    end
    L1;
    
    while L1 > 0.0001
        U = U_new;
        for k = 1:szZ(1,1)
            for i = 1:szU(1,1)
                numerator = 0;
                denomirator = 0;
                for j = 1:length(Z)
                    numerator = numerator + (U(i, j).^2) * Z(k, j);
                    denomirator = denomirator + U(i, j).^2;
                end
                v(k, i)=numerator/denomirator;
            end
        end
        v;
        
        for j = 1:length(Z)
            for i = 1:szU(1,1)
                d2(i, j) = 0;
                for k = 1:szZ(1,1)
                    d2(i, j) = d2(i, j) + (v(k, i) - Z(k, j)).^2;
                end
            end
        end
        d2;
        
        for j = 1:length(Z)
            m = 0;
            for k = 1:szU(1, 1)
                if d2(k,j) == 0
                    m = m + 1;
                end
            end
            if m == 0
                for i = 1:szU(1,1)
                    Sum = 0;
                    for k = 1:szU(1,1)
                        Sum = Sum + (d2(i, j)/d2(k, j));
                    end
                    U_new(i,j) = 1/Sum;
                end
            else
                for l = 1:szU(1, 1)
                    if d2(l, j) == 0
                        U_new(l, j) = 1/m;
                    else
                        U_new(l, j) = 0;
                    end
                end
            end
        end
        U_new;
        
        L1 = 0;
        for i = 1:szU(1,1)
            for j = 1:length(Z)
                dist(i, j) = abs(U_new(i, j) - U(i, j));
                if dist(i, j) > L1
                    L1 = dist(i, j);
                end
            end
        end
        L1;
    end
    U_new;
    L1;
    prior = [prior U_new(:, end)];
end
prior;

% Result
p1 = prior(1, :);
p2 = prior(2, :);

prior_FCM = U(:, end)

save('prior_FCM.mat','p1','p2', 'prior_FCM')

