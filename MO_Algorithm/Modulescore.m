function score=Modulescore(PopulationNon,pernd,mean,std,md)
   a=size(PopulationNon,1);
   for i=1:a
       Pop=PopulationNon(i,:);
                 
               [c,e]=find(Pop);    %ͳ�Ƹ�����1�ĸ���������λ��
               v=length(c);      %ѡ��Ľڵ���
               d=0;  p=0;  w=0; sum=0;
                                     
               for b=1:(v-1)          %ͳ�Ʊ�ѡ��Ľڵ�֮��ı������    
                   for g=(b+1):v                   
                       if pernd(e(b),e(g))~=0 
%                            w=pernd(e(b),e(g));
%                            p=pernd(e(g),e(b));
                             d=d+1;
%                            sum=sum+w*p;
                           sum=sum+pernd(e(b),e(g));
                       end                    
                   end
               end
               
       score(i,1)=(sum-d*mean)/(d*std);
%        score1(i,1)=(sum-d*mean)/(v*std);
%        score(i,1)=(sum-v*md*mean)/(v*std);
%        score3(i,1)=sum/(v*std);
%        score4(i,1)=(sum-v*md*mean)/std;
   end
end

