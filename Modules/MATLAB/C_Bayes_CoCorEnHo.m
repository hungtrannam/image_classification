load('glcm_data.csv')

%Khai bao du lieu 
Train_X = [glcm_data(:, 1) glcm_data(:, 2) glcm_data(:, 3) glcm_data(:, 4)];
Train_Y = glcm_data(:, end) + 1;

tic
% Standard data
StandardData1 = MinAbsScale(Train_X);
StandardData2 = MinMaxScale(StandardData1, 4);

TrainData = [StandardData2 Train_Y];

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


X1_1 = [];
X2_1 = [];
X3_1 = [];
X4_1 = [];

X1_2 = [];
X2_2 = [];
X3_2 = [];
X4_2 = [];

for i = 1:length(TrainData)
    if TrainData(i,end) == 1 
        X1_1 = [X1_1; TrainData(i,1)];
        X2_1 = [X2_1; TrainData(i,2)];
        X3_1 = [X3_1; TrainData(i,3)];
        X4_1 = [X4_1; TrainData(i,4)];
    end
    if TrainData(i,end)== 2
        X1_2 = [X1_2; TrainData(i,1)];
        X2_2 = [X2_2; TrainData(i,2)];
        X3_2 = [X3_2; TrainData(i,3)];
        X4_2 = [X4_2; TrainData(i,4)];
    end
end

f1_1 = ksdensity(X1_1,TestData(:,1));
f2_1 = ksdensity(X2_1,TestData(:,2));
f3_1 = ksdensity(X3_1,TestData(:,3));
f4_1 = ksdensity(X4_1,TestData(:,4));

f1 = (f1_1).*(f2_1).*(f3_1).*(f4_1);

f1_2 = ksdensity(X1_2,TestData(:,1));
f2_2 = ksdensity(X2_2,TestData(:,2));
f3_2 = ksdensity(X3_2,TestData(:,3));
f4_2 = ksdensity(X4_2,TestData(:,4));

f2 = (f1_2).*(f2_2).*(f3_2).*(f4_2);

% Calculate Bayes Error
[acc, p1, p2] = accuracy('BayesC', TrainData, TestData, f1, f2)

toc
