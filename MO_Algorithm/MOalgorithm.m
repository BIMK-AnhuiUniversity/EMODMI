% 0   NSGA-II
function [PopulationNon,FunctionValueNon,result,pv,fund]=MOalgorithm(pernssn,B,avg,stdf)
%     clc;
    format compact;tic;
     addpath(genpath(fileparts(mfilename('fullpath'))));
    %-----------------------------------------------------------------------------------------
   
    Run=1;
    Problem = 'DMD';
    M=2;
    Algorithm='MODMDA';
   
    Generations=500;
    N=100;
   
    fund=[];
    result=[];
    pv=[];
    load agadxu;
    difxu=importdata('difzxu.mat');
    pathxu=importdata('path1mxu.mat');
    agosxu=importdata('agosxu.mat');
    

     %load('pernssn.mat');
     %weight=importdata('pernssn.mat');
     weight=pernssn;
     poplength=size(weight,1);
    %%
    Degree=sum(logical(weight),2);
    mD=sum(Degree,1)/size(Degree,1);

    Population=Initialization(N, poplength,weight,B,Degree);
%     Population=(rand(N, poplength)<0.01);
    
    Boundary=[1;0];
    Boundary=repmat(Boundary,1,poplength);
    Coding='Binary';
   %FunctionValue
  
  
   functionvalue=Func(Population,pernssn,data,refn,pinw);
    
    FunctionValue=functionvalue;
%     FunctionValue                = P_objective('value',Problem,M,Population);
    FrontValue                   = F_NDSort(FunctionValue,'half');
    CrowdDistance                = F_distance(FunctionValue,FrontValue);

    %%
    for Gene = 1 : Generations
        %
        MatingPool            = F_mating(Population,FrontValue,CrowdDistance);
        
        Offspring             = P_generator(MatingPool,Boundary,weight,Coding,N,Degree,B);%%½»²æ±äÒì        
        
        functionvalue=zeros(N,2);      
        
        functionvalue= Func(Offspring,pernssn,data,refn,pinw);                  
                   
        Population            = [Population;Offspring];
        FunctionValue=[FunctionValue;functionvalue];
%         FunctionValue         = P_objective('value',Problem,M,Population);
        %
%         figure(3);
%         plot( FunctionValue(:,1), FunctionValue(:,2),'*r');
%         pause(0.01);

        [FrontValue,MaxFront] = F_NDSort(FunctionValue,'half');
        CrowdDistance         = F_distance(FunctionValue,FrontValue);

        %
        Next        = zeros(1,N);
        NoN         = numel(FrontValue,FrontValue<MaxFront);
        Next(1:NoN) = find(FrontValue<MaxFront);

        %
        Last          = find(FrontValue==MaxFront);
        [~,Rank]      = sort(CrowdDistance(Last),'descend');
        Next(NoN+1:N) = Last(Rank(1:N-NoN));

        %
        Population    = Population(Next,:);
        FrontValue    = FrontValue(Next);
        FunctionValue = FunctionValue(Next,:);
        CrowdDistance = CrowdDistance(Next);

        %Record IGD Value
        %IGD(Gene) = P_evaluate('IGD', FunctionValue, TruePoint);
        [~,MaxFront] = F_NDSort(FunctionValue,'all');

        %clf;
        %P_draw(FunctionValue);
        %pause(0.1);
        
        
        if rem(Gene,1)==0
            NonDominated       =    P_sort(FunctionValue,'first')==1;
            PopulationNon    =    Population(NonDominated,:);
            FunctionValueNon =  FunctionValue(NonDominated,:);
            
           score=Modulescore(PopulationNon,pernssn,avg,stdf,mD);
           [mvalue,rows]=max(score);
           diseasemoudle=PopulationNon(rows,:);
           fund=[fund;FunctionValueNon(rows,:)];
           dis=find(diseasemoudle);
           
           kr=size(intersect(dis,agadxu'),2);
           difr=size(intersect(dis,difxu'),2);
           pathr=size(intersect(dis,pathxu'),2);
           gor=size(intersect(dis,agosxu'),2);
           
           m=size(pernssn,1);
           n=size(dis,2);
           
           kk=size(agadxu,1);
           kd=size(difxu,1);
           kp=size(pathxu,1);
           kg=size(agosxu,1);
           %know
           xk=1:kk;
           ppk=hygepdf(xk,m,kk,n);
           pk=sum(ppk(1,kr:end));
           %dif
           xd=1:kd;
           ppd=hygepdf(xd,m,kd,n);
           pd=sum(ppd(1,difr:end));
           %pathway
           xp=1:kp;
           ppp=hygepdf(xp,m,kp,n);
           pp=sum(ppp(1,pathr:end));
           %GO
           xg=1:kg;
           ppg=hygepdf(xg,m,kg,n);
           pg=sum(ppg(1,gor:end));
         
           pv=[pv;pk,pd,pp,pg];
           result=[result;kr,difr,pathr,gor,size(dis,2)];
        end
        %
        clc;
        fprintf([Algorithm,',Run %2s, Problem %5s, Dim %2s, Complete %4s%%, Speed %5ss, MaxFront %d\n'],...
        num2str(Run),...
        Problem,...
        num2str(M),...
        num2str(roundn(Gene/Generations*100,-1)),...
        num2str(roundn(toc,-2)),...
        MaxFront);

    end   
   
    %-----------------------------------------------------------------------------------------
    %% output  
     Population;
     FunctionValue;
    
     NonDominated       =    P_sort(FunctionValue,'first')==1;
     PopulationNon    =    Population(NonDominated,:);
     FunctionValueNon =  FunctionValue(NonDominated,:);
     plot( FunctionValueNon(:,1), FunctionValueNon(:,2),'*r');
      xlabel('avgw');
      ylabel('v/d');
     % zlabel('close');
      title('NSGAII');
  
end
