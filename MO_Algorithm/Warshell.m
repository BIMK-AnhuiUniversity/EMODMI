function S=Warshell(D)
%Warshell�㷨
n=size(D,1);
S=0;
a=1;
G=zeros(n,1);
for i=1:n
    for j=(i+1):n
        if D(i,j)==1    %���б�
            if G(i)==G(j)  %������֮������ͨ����˵��������ͬһ��ͨ��֧
                if G(i)==0
                    G(i)=a;
                    G(j)=a;
                    a=a+1;
                    S=S+1;
                end
            else
                if G(i)==0
                    G(i)=G(j);   %����i����ͨ������j��ͬһ��ͨ��֧
                else
                    if G(j)==0
                        G(j)=G(i);   %����j����ͨ������i��ͬһ��ͨ��֧
                    else   %����������ͨ��������ڲ�ͬ��ͨ��֧���ϲ�����ͨ��֧
                        for b=1:n
                            if G(b)==G(i)
                                G(b)=G(j);   %�ϲ�����ͨ��֧
                            end
                        end
                        S=S-1;   %�ϲ�����ͨ��֧
                    end
                end
            end
        end
    end
end