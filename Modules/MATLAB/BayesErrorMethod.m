function [BayesError, p1, p2] = BayesErrorMethod(bayes, traindata, testdata, f1, f2)
% bayes: four options: {'BayesU' 'BayesL' 'BayesT' 'BayesC'}
% train: Data has been standarded via Min-Max scale
% testdata:
% f1: ksdensity X_1 ans testdata
% f2: ksdensity X_2 and testdata

p = [0; 0;];

for i=1:length(traindata)
    if traindata(i,end) == 1 
        p(1,1) = p(1,1)+1;
    end
    if traindata(i,end) == 2 
        p(2,1) = p(2,1)+1;
    end
end

if bayes == 'BayesU'
    p1 = 1/2;
    p2 = 1/2;    
elseif bayes == 'BayesL'
    p1 = (p(1,1)+1) / (sum(p)+2);
    p2 = (p(2,1)+1) / (sum(p)+2);    
elseif bayes == 'BayesT'
    p1 = p(1,1) / sum(p);
    p2 = p(2,1) / sum(p);
elseif bayes == 'BayesC'
    load('prior_FCM.mat');
end

g1 = (p1').*f1;
g2 = (p2').*f2;

gtmin = min(g1,g2);

BayesError = 1 - sum(gtmin)/length(testdata);

if bayes == 'BayesC'
    p1 = prior_FCM(1,1);
    p2 = prior_FCM(2,1);
else
    p1;
    p2;
end
