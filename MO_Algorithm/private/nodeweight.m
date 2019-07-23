function [avgnodew,avgnodep,fit]=nodeweight(weight,poplength)
      W1=triu(weight);
      W2=W1';
      W=W1+W2;
      
        P1=tril(weight);       
        P2=P1';
        P=P1+P2;
             
      nodew=sum(W,1);
               D=logical(W);
               noded=sum(D,1);
               for i=1:poplength
                   avgnodew(1,i)=nodew(1,i)/noded(1,i);
               end
               
       nodep=sum(P,1);
               D=logical(P);
               noded=sum(D,1);
               for i=1:poplength
                   avgnodep(1,i)=nodep(1,i)/noded(1,i);
               end
               
       DU=logical(weight);
             for i=1:poplength
                 d=sum(DU(i,:)==1);
                 p=sum(P(i,:));
                 w=sum(W(i,:));
                 fit(i)=0.5*w/d+0.5*p/d;
             end         
               
               
end