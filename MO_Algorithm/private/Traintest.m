function [Trainset,Testset]=Traintest(set)
%% 将数据集分为Trainset和Testset
%   load Dnormal.mat;
%    set=D;
setn=set(1:20,:);
setd=set(21:end,:);
          a=size(setn,1);
          b=size(setd,1);
          A=randperm(a);
          B=randperm(b);
          c=0;
          d=0;
          for i=1:a
              if i<=0.3*a
                  c=c+1;
                  Testset(c,:)=setn(A(i),:);
              else
                  d=d+1;
                  Trainset(d,:)=setn(A(i),:);
              end
          end
          for i=1:b
              if i<=0.3*b
                  c=c+1;
                  Testset(c,:)=setd(B(i),:);
              else
                  d=d+1;
                  Trainset(d,:)=setd(B(i),:);
              end
          end
end
                  
          
