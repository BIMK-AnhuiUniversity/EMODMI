function [output]=output(pernssn,PopulationNon,FunctionValueNon)
  
     g=1;
     for i=1:size(FunctionValueNon,1)
          a=PopulationNon(i,:);
            [c,e]=find(a);    %ͳ�Ƹ�����1�ĸ���������λ��
            v=length(c);      %ѡ��Ľڵ���
            
            h=1;
            for b=1:(v-1)          %ͳ�Ʊ�ѡ��Ľڵ�֮��ı������    
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
     end            %����һǰ����ĸ����Ӧ�ı߼�����ֵ���
end