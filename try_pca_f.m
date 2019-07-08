load('Transformed_data.mat');
A=num2cell(data);
testt=[];
tt=0;
t=1;
sample=[2 5 4 3 1]';
for i=1:1:50
    y1(t,:)=A{i,sample(1)};
    y1(t+1,:)=A{i,sample(2)};
    y1(t+2,:)=A{i,sample(3)};
    y1(t+3,:)=A{i,sample(4)};
    t=t+4;
end
for i=1:50
    y2(i,:)=A{i,sample(5)};
end
n_train=4;
n_test=1;
tot=n_train+n_test;
trainn=[];
testt=[];
c=1;
for i=1:4:size(y1,1)
    trainn=[trainn; y1([i:i+3],1:end)];
    tt=tt+1;
    testt=[testt;y2(c,1:end)];
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