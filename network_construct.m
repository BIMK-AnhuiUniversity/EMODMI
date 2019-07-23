function network_construt()
% load data;
% load refnsample;
% load pinw;
pinw=importdata('pinw.mat');
da=importdata('datap.mat');

refnsample=da(:,1:20);
data=da(:,21:108);


% %%
% %% original network
% sample=da(:,1:end);
% [u,v]=size(sample);
% original=zeros(u,u);
% for i=1:(u-1)
%     for j=(i+1):u
%         a=sample(i,:);
%         b=sample(j,:);
%         if pinw(i,j)==1              
%                 t=abs(corrcoef(a,b));
%             else
%                 t=[0 0;0 0];
%         end
%         
%            original(i,j)=t(1,2);
%            original(j,i)=original(i,j);
%         
%     end 
% end

% %
% [a,b]=size(refnsample);
% c=randperm(b);
% d=c(:,1:(ceil(b/2)));
% refnsample=refnsample(:,d(:,:));
% 
%% reference network
[u,v]=size(refnsample);
refn=zeros(u,u);
for i=1:(u-1)
    for j=(i+1):u
        a=refnsample(i,:);
        b=refnsample(j,:);
%         if pinw(i,j)==1              
                t=abs(corrcoef(a,b));
%             else
%                 t=[0 0;0 0];
%         end
        
           refn(i,j)=t(1,2);
           refn(j,i)=refn(i,j);
        
    end 
end

%% sample
p=size(refn,1);
[m,n]=size(data);
j=v+1;
newdata=refnsample;
for i=1:n
    newdata(:,j)=data(:,i);
    newdata=[newdata,refnsample];
    j=j+v+1;
end
perndata=newdata(:,1:n*(v+1));

%% perturbation network
% for g=1:size(data,2)
%     perndata=[refnsample,data(:,g)];
pernssn=zeros(m,m);
for i=1:(m-1)
    i
    for j=(i+1):m
        w=0;t=0;
        for h=1:(v+1):(n*(v+1))
            difssn=0;
            a=perndata(i,h:(h+v));
            b=perndata(j,h:(h+v));
            if pinw(i,j)==1              
                cor=abs(corrcoef(a,b));
            else
                cor=[0 0;0 0];
            end
            
            difssn=abs(abs(cor(1,2)-refn(i,j)));
            z=difssn/((1-refn(i,j)*refn(i,j))/(v-1));
            if z>=1.96
                w=w+difssn;
                t=t+1;
            end            
        end
        if t~=0          
            pernssn(i,j)=w/t;
            pernssn(j,i)=t/n;  

        end
    end
end

%eage weight
   pernpw=zeros(m,m);
   for i=1:(m-1)
       for j=(i+1):m
           pernpw(i,j)=pernssn(i,j)*pernssn(j,i);
           pernpw(j,i)=pernpw(i,j);
       end
   end
  
   addpath('./data_process')
%    load P;
%    load W;
% load pernpw;
   a=0;
   [mean,std]=ccount(pernpw);
   [Bpw,arc]=betweenness_centrality(sparse(pernpw));
% %   
%    [meano,stdo]=ccount(original);
%    [Bo,arco]=betweenness_centrality(sparse(original));
% %    
%     [meanp,stdp]=ccount(pinw);
%    [Bpin,arcp]=betweenness_centrality(sparse(pinw));
% %    
%    prpw=PR(pernpw);
%    prw=PR(W);
   
end

           
   


