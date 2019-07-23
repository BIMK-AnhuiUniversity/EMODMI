%% classify
function classify()
clc;clear;
pinw=importdata('pinw.mat');
datap=importdata('datap.mat');
data=importdata('data.mat'); 
load pernpw;
load dis_240;
disnet=pernpw(dis(:,:),dis(:,:));
refnsample=datap(:,1:20);
%% reference network construction
[u,v]=size(refnsample);
refn=zeros(u,u);
for i=1:(u-1)
    for j=(i+1):u
        a=refnsample(i,:);
        b=refnsample(j,:);
        if pinw(i,j)==1              
                t=abs(corrcoef(a,b));
            else
                t=[0 0;0 0];
        end
           refn(i,j)=t(1,2);
           refn(j,i)=refn(i,j);       
    end 
end
%% perturbation network
[m,n]=size(datap);

for g=1:size(datap,2)
    refndis=[refnsample,datap(:,g)];  
    pern=zeros(u,u);
    pd=0;
    for i=1:(u-1)        
        for j=(i+1):u
            w=0;t=0;
            a=refndis(i,:);
            b=refndis(j,:);
            if pinw(i,j)==1
                cor=abs(corrcoef(a,b));
            else
                cor=[0 0;0 0];
            end
            
            difssn=abs(abs(cor(1,2)-refn(i,j)));
            z=difssn/((1-refn(i,j)*refn(i,j))/(v-1));
            if z>=1.96  
                pd=pd+1;
               pern(i,j)=difssn;
               pern(j,i)=pern(i,j);         
            end
        end
    end  
    pernnet=pern(dis(:,:),dis(:,:));
    %graph editing distance
    D=0;
    for pi=1:size(pernnet,1)-1
        for pj=pi+1:size(pernnet,1)
           if disnet(pi,pj)~=pernnet(pi,pj)
                if disnet(pi,pj)==0||pernnet(pi,pj)==0
                    d=abs(disnet(pi,pj)-pernnet(pi,pj));                    
                else
                    d=1/2*abs(disnet(pi,pj)-pernnet(pi,pj));                  
                end
                D=D+d;                   
           end                      
        end      
    end
        Dd(1,g)=D;    
end 

%KNN
  Dd=[Dd',data(:,end)];

  for i=1:50
     d=Dd(:,end);
     M=size(Dd,1);
     indices=crossvalind('Kfold',M,5);
    for bb=1:5
         testdataset=Dd(indices==bb,1:end-1);
         testdatalabel=d(indices==bb);
         traindataset=Dd(indices~=bb,1:end-1);
         traindatalabel=d(indices~=bb);         
 
    mdl =ClassificationKNN.fit(traindataset,traindatalabel,'NumNeighbors',5);
    predict_label   =       predict(mdl, testdataset);
    errorate(bb)         =1-length(find(predict_label == testdatalabel))/length(testdatalabel);
    
   end
    output1(i,1)=mean(errorate);
  end
  output=mean(output1,1);
  ostd=std(output1,1);
%

end
