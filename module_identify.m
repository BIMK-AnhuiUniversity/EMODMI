function module_identify()

addpath('./MO_Algorithm')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% 
B=importdata('Bpw.mat');
% B=B';
avg=importdata('mean.mat');
stdf=importdata('std.mat');
pernd=importdata('pernpw.mat');
%%
     [PopulationNon,FunctionValueNon,result,pv,fund]=MOalgorithm(pernd,B,avg,stdf);

score=Modulescore(PopulationNon,pernd,avg,stdf);
[mvalue,rows]=max(score);

diseasemoudle=PopulationNon(rows,:);
dis=find(diseasemoudle);
diseasefvalue=FunctionValueNon(rows,:);
% network=final_network(diseasemoudle,pernd);
% D=logical(network);
% s=Warshell(D);

   
end
 
 

