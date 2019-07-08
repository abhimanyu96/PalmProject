clc
clear all
% close all
% 
% load roi_gauss_train_all
% load roi_gauss_testnrm_all

% data_mat3=data_mat2;
% clear data_mat2;
% load roi_gauss_testnm06

load('PalmPrintIITD_GMF.mat');
sample=[2 5 4 3 1]';
% load('PalmPrintIITD_GMF2.mat')

for rot=1:5
    sample=circshift(sample,1);
% load('gfi_train.mat')
% load('gfi_test.mat')
% load gfi_entrp_train
testt=[];
tt=0;

% kk=0.02;
% for i=1:size(feat1,2)
% feat1(:,i)=feat1(:,i)/max(max(feat1));    
% end
% y1=feat1;
% y1=cell(10,1);
t=1;
for i=1:1:50
    y1(t,:)=PalmPrintIITD_GMF{i,sample(1)};
    y1(t+1,:)=PalmPrintIITD_GMF{i,sample(2)};
    y1(t+2,:)=PalmPrintIITD_GMF{i,sample(3)};
    y1(t+3,:)=PalmPrintIITD_GMF{i,sample(4)};
%     y1(t+4,:)=PalmPrintIITD_GMF{i,sample(5)};
    t=t+4;
end

for i=1:50
    y2(i,:)=PalmPrintIITD_GMF{i,sample(5)};
end

% for i=1:100
%     y3(i,:)=PalmPrintIITD_GMF{i,sample(6)};
%     {i,6};
% end

% y1=PalmPrintIITD_GMF1{1:10,1};
% y2=PalmPrintIITD_GMF1{1:10,2};
% y3=PalmPrintIITD_GMF1{1:10,3};

n_train=4;
n_test=1;
tot=n_train+n_test;
trainn=[];
testt=[];
c=1;
%  for i=1:tot:size(y1,1)
%     tt=tt+1;
%     trainn=[trainn; y1(i:i+n_train-1,:)];
%     testt=[testt; y1(i+n_train:i+tot-1,:)];
% end
for i=1:4:size(y1,1)
    trainn=[trainn; y1([i:i+3],1:end-1)];
    tt=tt+1;
    testt=[testt;y2(c,1:end-1)];
    c=c+1;
end
genuine=[];
imposter=[];
for  jj=1:size(testt,1)
      jj
      tt=0 ;
    for i=1:n_train:size(trainn,1)
        tt=tt+1;
        for j=1:size(trainn,2)
            for mm=0:n_train-1
            e(tt,mm+1,j)=abs(testt(jj,j)-trainn(i+mm,j));
            end
            countt=0;
           
        end  
        prod=1;

          for lt=1:n_train
            h(tt,lt)=sum(e(tt,lt,:));
          end
          h1(jj,tt)=min(h(tt,:));           
           if(jj==tt)
               genuine=[genuine h1(jj,tt)];
           else
               imposter=[imposter h1(jj,tt)];
           end
        end
end
 

      save score_gauss genuine imposter
for jj=1:size(testt,1)
[minn indd(jj)]=min(h1(jj,:));
end
recog=0;
tt=0;
for i=1:1:size(testt,1)
    tt=tt+1;
    if(indd(i)==tt)
        recog=recog+1;
    end
%     if(indd(i+1)==tt)
%         recog=recog+1;
%     end
end
 recog
score1=[genuine imposter];
% size(genuine)
% size(imposter)
% labels=[ones(1,19) zeros(1,342)];
% % 
% [X,Y] = perfcurve(labels,score1,1);
% plot(X,Y)
 score2=max(score1);
  genuine=genuine./score2;
  imposter=imposter./score2;
  SCORE_MAT_VEIN=h1./score2;
% max(genuine)
% min(genuine) 
% max(imposter)
% min(imposter)
th1=0;
th2=1;
step=0.01;
label_x=(th1:step:th2); 
    [a bc2]=size(genuine);
    l=1;
    m1=1;
%     
    for th=th1:step:th2
        c=0;
      for r=1:bc2
           if(genuine(r)>=th)
            c=c+1;
           
           end
      end
            FRR(l)  =  (100*c)/bc2;
      
            l=l+1;
            m1=m1+1;
    end
     
%          
    [a bc3]=size(imposter);
    l=1;
    m2=1;
    for th=th1:step:th2
        y=0;
      for r1=1:bc3
           if(imposter(r1)<=th)
            y=y+1;
           end
      end
        FAR(l)  =  (100*y)/bc3;
        l=l+1;
        m2=m2+1;
    end 
    
    Recog(rot)=recog;
end
    
figure,semilogx(FAR,100-FRR)

ylabel('GAR'); 
xlabel('FAR');
ylabel('GAR');
% % 
 mean(Recog)*2

% % 
% %   
% % %  save roi_smbg recog
% 
% 
% %  toc