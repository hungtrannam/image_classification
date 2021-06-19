function [acc, p1, p2] = accuracy(bayes, TrainData, TestData, f1, f2)
% bayes: four options: {'BayesU' 'BayesL' 'BayesT' 'BayesC'}
% train: Data has been standarded via Min-Max scale
% testdata:
% f1: ksdensity X_1 ans testdata
% f2: ksdensity X_2 and testdata

p = [0; 0;];

for i=1:length(TrainData)
    if TrainData(i,end) == 1 
        p(1,1) = p(1,1)+1;
    end
    if TrainData(i,end) == 2 
        p(2,1) = p(2,1)+1;
    end
end

if bayes == 'BayesU'
    p1 = 1/2;
    p2 = 1/2;    
    fprintf('Prior Probabilibty has been found via uniform dist.\n')
elseif bayes == 'BayesL'
    p1 = (p(1,1)+1) / (sum(p)+2);
    p2 = (p(2,1)+1) / (sum(p)+2);    
    fprintf('Prior Probabilibty has been found via Laplace method.\n')
elseif bayes == 'BayesT'
    p1 = p(1,1) / sum(p);
    p2 = p(2,1) / sum(p);
    fprintf('Prior Probabilibty has been found via trainning test.\n')
elseif bayes == 'BayesC'
    [prior_C, p1,p2] = prior_FCM(TrainData);
    fprintf('Prior Probabilibty has been found via FCM.\n')
end

g1 = (p1').*f1;
g2 = (p2').*f2;

gtmin = min(g1,g2);

fprintf('Accuracy:\n')
acc = 1 - sum(gtmin)/length(TestData);

if bayes == 'BayesC'
    p1 = prior_C(1,1);
    p2 = prior_C(2,1);
else
    p1;
    p2;
end
