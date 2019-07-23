function [Trainset,Testset]=Traintest(set)
%% 将数据集分为Trainset和Testset
%   load Dnormal.mat;
%    set=D;
          a=size(set,1);
          A=randperm(a);
          b=0;
          c=0;
          for i=1:a
              if i<=0.3*a
                  b=b+1;
                  Testset(b,:)=set(A(i),:);
              else
                  c=c+1;
                  Trainset(c,:)=set(A(i),:);
              end
          end
% end
                  
          
