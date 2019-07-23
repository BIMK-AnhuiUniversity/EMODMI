function network=final_network(diseasemoudle,pernd)

     [c,e]=find(diseasemoudle);
     L=size(e,2);
     b=size(diseasemoudle,2);
     
     network=pernd;
     for k=b:-1:e(L)+1
          network(k,:)=[];
          network(:,k)=[];
     end

     for i=L:-1:2
         for j=e(i)-1:-1:e(i-1)+1
             network(j,:)=[];
             network(:,j)=[];
         end
     end

     for h=e(1)-1:-1:1
         network(h,:)=[];
         network(:,h)=[];
     end
end