clear; clc; 
close all;

load C4_F200.mat

% load train.mat
% load test.mat
% data = [train test];

x = 0:.001:1;
epsilon = .00001;
fmi=0;
mc = [2];
fv=[];
W=[];
ff=[];
h = 10; %Số 

d = 'CityBlock';

% % %% Bat dau thuat toan
for k=1:h
A = data;
% idx = randsample(size(A,2),size(A,2)*.8);
% train=A(:,idx);
% test=setdiff(A',train','rows')';
cv = cvpartition(size(A,2),'HoldOut',0.2);
idx = cv.test;
% Separate to training and test data
train = A(:,~idx);
test  = A(:,idx);

FileName = strcat('I',sprintf('%.2d', k), '.mat');
save(FileName,'train','test');
fprintf('Sample %s has been created.\n', FileName);
end

for kk=1:h
FileName = strcat('I',sprintf('%.2d', kk), '.mat');
%  FileName = 'I02.mat'
load(FileName);
% load train.mat
% load test.mat


%% Bat dau thuat toan

tic

%tao Z va U cho tap train
Z1=train(1:end-1,:);
U1=zeros(max(train(end,:)),size(train,2));
for i=1:size(train,2)
    U1(train(end,i),i)=1;
end
%tinh v cho tap train
% v_train=zeros(size(U1,1),size(Z1,2));
% for i=1:size(v_train,1)
%     idx=find(train(end,:)==i);
%     v_train(i,:)=mean(Z1(idx,:));
% end

%tao Z va U cho tap test
Z2=test(1:end-1,:);
U2=ones(max(train(end,:)),size(test,2))*1/max(train(end,:));

%tao Z va U chung
f=[Z1'; Z2']';
U=[U1 U2];

tic

fmi=0;

for fm=mc
    fmi=fmi+1;

    szU=size(U);
        %Tinh phan tu dai dien chum
        for i=1:szU(1,1)
            fv(:,i)=f*(U(i,:)'.*U(i,:)')/sum(U(i,:).*U(i,:));
        end
        fv;
 

    %Tính ma tran do rong chum
    for j=1:szU(1,2)
        for i=1:szU(1,1)
            %W(i,j)=DistanceL1(f(i,:),f(j,:),x);
            %W(i,j)=dorongchum([fv(:,i),f(:,j)],x);
            %W(i,j)=DistanceSLC([fv(:,i),f(:,j)],x);
            %W(i,j)=DistanceHausdorff(fv(:,i),f(:,j));
            %W(i,j)=DistanceSimilarityPDFs(fv(:,i),ftrain(:,j), 'Euclidean');
            W(i,j)=DistanceSimilarityPDFs(fv(:,i),f(:,j), d);
            %W(i,j)=DistanceSimilarityPDFs(fv(:,i),f(:,j), 'CityBlock');
        end
    end
    W;

    %Cap nhat ma tran phan vung
    for j=1:szU(1,2)
        m=0;
        for k=1:szU(1,1)
            if W(k,j)==0
                m=m+1;
            end
        end
        if m==0
            for i=1:szU(1,1)
                tong=0;
                for k=1:szU(1,1)
                    tong=tong+(W(i,j)^(2/(fm-1)))/(W(k,j)^(2/(fm-1)));
                end
                Umoi(i,j)=1/tong;
            end
        else
            for l=1:szU(1,1)
                if W(l,j)==0
                    Umoi(l,j)=1/m;
                else
                    Umoi(l,j)=0;
                end
            end
        end
    end
    Umoi;

    %Tinh chuan
    chuan=0;
    for i=1:szU(1,1)
        for j=1:szU(1,2)
            lech(i,j)=abs(Umoi(i,j)-U(i,j));
            if lech(i,j)>chuan
                chuan=lech(i,j);
            end
        end
    end
    chuan;
    ff=[ff;chuan];
    %lap lai thuat toan cho den khi chuan nho hon exilanh cho truoc 
    vonglap=0;
    while chuan>epsilon
        U=Umoi;
        vonglap=vonglap+1
        %Tinh phan tu dai dien chum
        for i=1:szU(1,1)
            fv(:,i)=f*(U(i,:)'.*U(i,:)')/sum(U(i,:).*U(i,:));
        end
        fv;

        %Tính ma tran do rong chum
        for j=1:szU(1,2)
            for i=1:szU(1,1)
            %W(i,j)=DistanceL1(f(i,:),f(j,:),x);
            %W(i,j)=dorongchum([fv(:,i),f(:,j)],x);
            %W(i,j)=DistanceSLC([fv(:,i),f(:,j)],x);
            %W(i,j)=DistanceHausdorff(fv(:,i),f(:,j));
            %W(i,j)=DistanceSimilarityPDFs(fv(:,i),f(:,j), 'Euclidean');           
            W(i,j)=DistanceSimilarityPDFs(fv(:,i),f(:,j), d);
            %W(i,j)=DistanceSimilarityPDFs(fv(:,i),f(:,j), 'CityBlock');
            end
        end
        W;

        %Cap nhat ma tran phan vung
        for j=1:szU(1,2)
            m=0;
            for k=1:szU(1,1)
                if W(k,j)==0
                    m=m+1;
                end
            end
            if m==0
                for i=1:szU(1,1)
                    tong=0;
                    for k=1:szU(1,1)
                        tong=tong+(W(i,j)^(2/(fm-1)))/(W(k,j)^(2/(fm-1)));
                    end
                    Umoi(i,j)=1/tong;
                end
            else
                for l=1:szU(1,1)
                    if W(l,j)==0
                        Umoi(l,j)=1/m;
                    else
                        Umoi(l,j)=0;
                    end
                end
            end
        end
        Umoi;

        %Tinh chuan
        chuan=0;
        for i=1:szU(1,1)
            for j=1:szU(1,2)
                lech(i,j)=abs(Umoi(i,j)-U(i,j));
                if lech(i,j)>chuan
                    chuan=lech(i,j);
                end
            end
        end
    end
    Umoi;
    Umoi=real(Umoi);
    chuan;
    ff=[ff;chuan];
    vonglap; 

    subplot(2,2,fmi)
    c = (size(train,2)+1):size(f,2);
%      b=area(Umoi'());
    b=bar3(Umoi(:,c));
    bottom = 0;
    top  = 1;
    for k = 1:length(b)
        zdata = b(k).ZData;
        b(k).CData = zdata;
        b(k).FaceColor = 'interp';
    end
    caxis manual
    caxis([bottom top]);
    title(['m = ',num2str(fm)])


end

hp4 = get(subplot(2,2,fmi),'Position');
colorbar('Position', [hp4(1)+hp4(3)+0.04  hp4(2)  0.02  hp4(2)+hp4(3)*2.1])

PLmatrix = Umoi.*(W);
[~, classes] = max(PLmatrix,[],1);
[maxU,C]=max(PLmatrix,[],1);
toc

% labels = A(end,:);
% ARI1=IndexRand(classes,labels);


%%
% SI=IndexSI(fv,A)
% DB=IndexDB(fv,A)
% SSE=IndexSSE(fv,A)
% ARI=IndexRand(C, A(end,:))

c = (size(train,2)+1):size(f,2);
[CM,~] =confusionmat(classes(:,c), test(end,:));
% figure
% cm = confusionchart(classes(:,c), test(end,:), ...
%     'RowSummary','row-normalized', ...
%     'ColumnSummary','column-normalized');
kappa = IndexCohensKappa(classes(:,c), test(end,:))
[precision, recall, f1_scrore, acc]=IndexF1Score(classes(:,c), test(end,:));
ACC(kk,:) = acc;
F1_SCORE(kk,:) = f1_scrore;
inter(kk,:)=vonglap;
times(kk,:)=toc;
% IG = indexIG(C);
end

%%
mean(times)
median(inter)
% mean(F1_SCORE)
mean(ACC)

%%
figure
p1=plot(x, fv(:,1), 'blue','LineWidth',2);
hold on
p2=plot(x, fv(:,2), 'red','LineWidth',2);
hold on 
% p3=plot(x, fv(:,3), 'green','LineWidth',2);
% hold on 
% p4= plot(x, fv(:,4), 'green','LineWidth',2);
% hold on
% p5= plot(x, fv(:,5), 'yellow','LineWidth',2);
% h = [p1(1);p2(1);p3(1);p4(1);p5(1)];
% legend(h, 'Up', 'Down', 'Left', 'Right', 'I');
hold off

figure
bar(Umoi(:,c)', "stacked");
legend('benign', 'malignant');


%%
% a=plot(x',data(1:end-1,data(end,:)==1),'blue');
% hold on
% b=plot(x',data(1:end-1,data(end,:)==2),'red','LineStyle','-');
% hold on 
% c=plot(x',data(1:end-1,data(end,:)==3),'green','LineStyle','--');
hold off

% l = [a(1);b(1)];
% legend(l, 'lung\_n', 'lung\_scc')

