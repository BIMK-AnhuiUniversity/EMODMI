function Offspring = P_generator(MatingPool,Boundary,weight,Coding,MaxOffspring,Degree,B)
% ����,���첢�����µ���Ⱥ
% ����: MatingPool,   �����, ����ÿ��i���͵�i+1�����彻����������Ӵ�, iΪ����
%       Boundary,     ���߿ռ�, ���һ��Ϊ�ռ���ÿά���Ͻ�, �ڶ���Ϊ�½�
%       Coding,       ���뷽ʽ, ��ͬ�ı��뷽ʽ���ò�ͬ�Ľ�����췽��
%       MaxOffspring, ���ص��Ӵ���Ŀ, ��ȱʡ�򷵻����в������Ӵ�, ���ͽ���صĴ�С��ͬ
% ���: Offspring, �������Ӵ�����Ⱥ

    [N,D] = size(MatingPool);
    if nargin < 3 || MaxOffspring < 1 || MaxOffspring > N
        MaxOffspring = N;
    end
    
    switch Coding
        %ʵֵ���桢����
        case 'Real'
            %�Ŵ���������
            ProC = 1;       %�������
            ProM = 1/D;     %�������
            DisC = 20;   	%�������
            DisM = 20;   	%�������

            %ģ������ƽ���
            Offspring = zeros(N,D);
            for i = 1 : 2 : N
                beta = zeros(1,D);
                miu  = rand(1,D);
                beta(miu<=0.5) = (2*miu(miu<=0.5)).^(1/(DisC+1));
                beta(miu>0.5)  = (2-2*miu(miu>0.5)).^(-1/(DisC+1));
                beta = beta.*(-1).^randi([0,1],1,D);
                beta(rand(1,D)>ProC) = 1;
                Offspring(i,:)   = (MatingPool(i,:)+MatingPool(i+1,:))/2+beta.*(MatingPool(i,:)-MatingPool(i+1,:))/2;
                Offspring(i+1,:) = (MatingPool(i,:)+MatingPool(i+1,:))/2-beta.*(MatingPool(i,:)-MatingPool(i+1,:))/2;
            end
            Offspring = Offspring(1:MaxOffspring,:);

            %����ʽ����
            if MaxOffspring == 1
                MaxValue = Boundary(1,:);
                MinValue = Boundary(2,:);
            else
                MaxValue = repmat(Boundary(1,:),MaxOffspring,1);
                MinValue = repmat(Boundary(2,:),MaxOffspring,1);
            end
            k    = rand(MaxOffspring,D);
            miu  = rand(MaxOffspring,D);
            Temp = k<=ProM & miu<0.5;
            Offspring(Temp) = Offspring(Temp)+(MaxValue(Temp)-MinValue(Temp)).*((2.*miu(Temp)+(1-2.*miu(Temp)).*(1-(Offspring(Temp)-MinValue(Temp))./(MaxValue(Temp)-MinValue(Temp))).^(DisM+1)).^(1/(DisM+1))-1);
            Temp = k<=ProM & miu>=0.5; 
            Offspring(Temp) = Offspring(Temp)+(MaxValue(Temp)-MinValue(Temp)).*(1-(2.*(1-miu(Temp))+2.*(miu(Temp)-0.5).*(1-(MaxValue(Temp)-Offspring(Temp))./(MaxValue(Temp)-MinValue(Temp))).^(DisM+1)).^(1/(DisM+1)));

            %Խ�紦��
            Offspring(Offspring>MaxValue) = MaxValue(Offspring>MaxValue);
            Offspring(Offspring<MinValue) = MinValue(Offspring<MinValue);
            
        %�����ƽ��桢����
        case 'Binary'
            %�Ŵ���������
%             ProM = 0.01;	
                        
%             %crossover
             Offspring = zeros(N/2,D);
             for i=1:N/2
                 Offspring(i,:)=MatingPool(2*i-1,:);
                                      
                 if rand()<0.5
                     a=MatingPool(2*i,:)-MatingPool(2*i-1,:);%add gene
                     a(a<0)=0;
                     [c,e]=find(a);
                     
%                      if rand()<0.5
%                         fit=Degree;
%                      else
                        fit=B;
%                      end
                     
                     if size(e)~=0
                        add=[];
                        for j=1:length(e)
                            add(j,1)=e(j);
                            add(j,2)=fit(e(j));
                        end
                       addrank=sortrows(add,-2);
                       b=randperm(ceil(length(addrank)/2));
                       c=round(rand(1,1)*ceil(length(addrank)/2));
                       for l=1:c
                           Offspring(i,addrank(b(l),1))=1;
                       end   
                     end
                     
                 else
%                      if rand()<0.5
%                         fit=Degree;
%                      else
                        fit=B;
%                      end
                     t=MatingPool(2*i-1,:)-MatingPool(2*i,:);
                     t(t<0)=0;
                     [~,e]=find(t);
                     if size(e)~=0 
                        sub=[];
                        for j=1:length(e)
                            sub(j,1)=e(j);
                            sub(j,2)=fit(e(j));
                        end
                        subrank=sortrows(sub,-2);

                        b=randperm(ceil(length(subrank)/2));
                        c=round(rand(1,1)*ceil(length(subrank)/2));
                        for l=1:c
                            Offspring(i,subrank(b(l),1))=0;
                        end    
                     end
                                     
                 end
             end
% 
%             %���Ƚ���
%             Offspring = zeros(N,D);
%             for i = 1 : 2 : N
%                 k = logical(randi([0,1],1,D));
%                 Offspring(i,:)   = MatingPool(i,:);   
%                 Offspring(i+1,:) = MatingPool(i+1,:);
%                 Offspring(i,k)   = MatingPool(i+1,k);
%                 Offspring(i+1,k) = MatingPool(i,k);
%             end
%             Offspring = Offspring(1:MaxOffspring,:);

%               %% mutation
%               one=ones(1,D);
%               for i=1:N/2  
%                   if rand()<0.5
%                       t=one-Offspring(i,:);
%                       [c,e]=find(t);
%                       
%                        if rand()<0.5
%                            fit=Degree;
%                        else
%                            fit=B;
%                        end
%                       
%                       if size(e)~=0
%                          add=[];
%                          for j=1:length(e)
%                              add(j,1)=e(j);
%                              add(j,2)=fit(e(j));
%                          end
%                           addrank=sortrows(add,-2);
% %                          b=randperm(ceil(length(addrank)/2));
% %                          c=round(rand(1,1)*ceil(length(addrank)/2));
% %                          for l=1:c
%                              Offspring(i,addrank(1,1))=1;
% %                          end
%                       end
%                   else
%                       t=Offspring(i,:);
%                       [c,e]=find(t); 
%                       
%                        if rand()<0.5
%                            fit=Degree;
%                        else
%                            fit=B;
%                        end 
%                  
%                       if size(e)~=0
%                          sub=[];
%                          for j=1:length(e)
%                              sub(j,1)=e(j);
%                              sub(j,2)=fit(e(j));
%                          end
%                          subrank=sortrows(sub,-2);
% %                          b=randperm(ceil(length(subrank)/2));
% %                          c=round(rand(1,1)*ceil(length(subrank)/2));
% %                          for l=1:c
%                              Offspring(i,subrank(1,1))=0;
% %                          end  
%                       end
%                   end
%               end

%% ����            
            m=size(weight,1);
            W=logical(weight);
            for i=1:N/2
                wai=[];
                inter=[];
                [c,e]=find(Offspring(i,:));
              if isempty(c)==0
%                 if size(c,2)<200
                if rand()>0.5  %add nodes
                    
                   for j=1:size(c,2)
                        wai=find(W(e(:,j),:));  
                        inter=union(inter,wai); 
                   end                
                   inter=setdiff(inter',e(:,:));
                   a=size(inter,2);
                   w=[];
                   for h=1:a
                       wai=find(W(inter(h),:));
                       nei=intersect(wai,e(:,:)); 
                       wai=setdiff(wai,nei);
                       w=[w;[size(nei,2),size(wai,2)]];  
                   end
%                 if isempty(w)==0
                   [b,f]=max(w(:,1));
                   Offspring(i,inter(f))=1;
                
                else   %subtract nodes
                
                    n=[];
                    for g=1:size(e,2)
                        wai=find(W(e(:,g),:));
                        nei=intersect(wai,e(:,:));
                        wai=setdiff(wai,nei);
                        n=[n;[size(nei,2),size(wai,2)]];
                    end             
                    [k,d]=min(n(:,1));              
                    Offspring(i,e(d))=0;
                end   
                else
                    d=ceil(rand(1,100)*D); 
                    Offspring(i,d(:,:))=1;
                end
            end


%%
%            %��׼����
%             k    = rand(MaxOffspring,D);
%             Temp = k<=ProM;
%             Offspring(Temp) = 1-Offspring(Temp);
             
        %����0-1��������Ķ����ƽ��桢����
        case 'Binary-MOKP'
            %�Ŵ��������� 
            ProM = 0.01;	%�������

            %���Ƚ���
            Offspring = zeros(N,D);
            for i = 1 : 2 : N
                k = logical(randi([0,1],1,D));
                Offspring(i,:)   = MatingPool(i,:);   
                Offspring(i+1,:) = MatingPool(i+1,:);
                Offspring(i,k)   = MatingPool(i+1,k);
                Offspring(i+1,k) = MatingPool(i,k);
            end
            Offspring = Offspring(1:MaxOffspring,:);

            %��׼����
            k    = rand(MaxOffspring,D);
            Temp = k<=ProM;
            Offspring(Temp) = 1-Offspring(Temp);

            %�޸�
            Offspring = P_objective('repair','MOKP',NaN,Offspring);
    end
end