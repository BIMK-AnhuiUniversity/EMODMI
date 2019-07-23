function [avg,sd]=ccount(pernssn)

[m,n]=size(pernssn);
% W1=triu(pernssn);
% W2=W1';
% W=W1+W2;
% 
%  Prob1=tril(pernssn);      
%  Prob2=Prob1';
%  Prob=Prob1+Prob2;
% 
% NumEdge=sum(sum(logical(pernssn),2))/2;

LWeight=logical(pernssn);
% LWeight=pernssn;
% EdgeW=zeros(NumEdge,4);
count=1;
for i=1:m
    for j=i+1:m
        if LWeight(i,j)~=0
%             EdgeW(count,:)=[i ,j,W(i,j),Prob(i,j)];
              EdgeW(count,:)=[i,j,pernssn(i,j)];

            count=count+1;
        end
    end
end
%%
% [m,n]=size(EdgeW);
% pw=zeros(m,3);
% for i=1:m
%     pw(i,1)=EdgeW(i,1);
%     pw(i,2)=EdgeW(i,2);
%     pw(i,3)=EdgeW(i,3)*EdgeW(i,4);
% end
% sortpw=sortrows(pw,-3);

% A=pw(:,3)';
A=EdgeW(:,3)';
avg=mean(A);
sd=std(A);
end



    