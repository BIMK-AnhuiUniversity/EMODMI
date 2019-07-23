function S=Warshell(D)
%Warshell算法
n=size(D,1);
S=0;
a=1;
G=zeros(n,1);
for i=1:n
    for j=(i+1):n
        if D(i,j)==1    %若有边
            if G(i)==G(j)  %若两端之间有连通链，说明二者在同一连通分支
                if G(i)==0
                    G(i)=a;
                    G(j)=a;
                    a=a+1;
                    S=S+1;
                end
            else
                if G(i)==0
                    G(i)=G(j);   %若与i不连通，则与j在同一连通分支
                else
                    if G(j)==0
                        G(j)=G(i);   %若与j不连通，则与i在同一连通分支
                    else   %若两端相连通，但标记在不同连通分支，合并两连通分支
                        for b=1:n
                            if G(b)==G(i)
                                G(b)=G(j);   %合并两连通分支
                            end
                        end
                        S=S-1;   %合并两连通分支
                    end
                end
            end
        end
    end
end