function score=Modulescore(PopulationNon,pernd,mean,std,md)
   a=size(PopulationNon,1);
   for i=1:a
       Pop=PopulationNon(i,:);
                 
               [c,e]=find(Pop);    %统计个体中1的个数及所在位置
               v=length(c);      %选择的节点数
               d=0;  p=0;  w=0; sum=0;
                                     
               for b=1:(v-1)          %统计被选择的节点之间的边相关量    
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

