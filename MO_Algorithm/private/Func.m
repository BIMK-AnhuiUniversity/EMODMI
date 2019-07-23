function functionvalue=Func(Population,pernssn)
      for i=1:size(Population,1)
              a=Population(i,:);
              [c,e]=find(a);   
               v=length(c);     
               d=0;  sum=0;
            
               for b=1:(v-1)       
                   for g=(b+1):v                   
                       if pernssn(e(b),e(g))~=0 
                           w=pernssn(e(b),e(g));
                           p=pernssn(e(g),e(b));
                           d=d+1;
                           sum=sum+p;                         
                       end                    
                   end
               end
               func(i,1)=sum;
               func(i,2)=v;
               func(i,3)=d;
      end
      
      summax=max(func(:,1));
      summin=min(func(:,1));
      if summin==0
          summin=0.001;
      end
      
      vmax=max(func(:,2));
      vmin=min(func(:,2));
      
      for j=1:size(func,1)
          if func(j,1)==0||func(j,2)==0
              functionvalue(j,1)=1;
              functionvalue(j,2)=1;
          else             
              functionvalue(j,1)=(summax-(func(j,1)-summin))/summax;
              functionvalue(j,2)=func(j,2)/func(j,3);%func(j,4);%
          end
      end
 end
                
          

