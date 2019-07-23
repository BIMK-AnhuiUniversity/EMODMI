function [output]=output(pernssn,PopulationNon,FunctionValueNon)
  
     g=1;
     for i=1:size(FunctionValueNon,1)
          a=PopulationNon(i,:);
            [c,e]=find(a);    %统计个体中1的个数及所在位置
            v=length(c);      %选择的节点数
            
            h=1;
            for b=1:(v-1)          %统计被选择的节点之间的边相关量    
                for k=(b+1):v
                        
                         if pernssn(e(b),e(k))~=0                        
                           output(h,g:(g+3))=[e(b),e(k),pernssn(e(b),e(k)),pernssn(e(k),e(b))];
                           h=h+1;
                        end
                    
                end
            end
            output(1,(g+4):(g+5))=FunctionValueNon(i,:);
            output(1,(g+6))=v;
            g=g+8;
     end            %将第一前沿面的个体对应的边及函数值输出
end