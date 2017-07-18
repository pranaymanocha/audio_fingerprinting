function helper4()

load('/share/workhorse2/pmanocha/video_all/MAP_database/New_dataset_test_AA.mat')
%count=1;
for i=1:4
for j=1:5
if nnz(A(i,j,:))==0

W(i,j)=1;
else
W(i,j)=nnz(A(i,j,:));
end


end
end




MAP= sum(A,3) ./ W;
Z=E(1,:);


if exist('/share/workhorse2/pmanocha/video_all/final_collection/123.mat', 'file') == 2
      load('/share/workhorse2/pmanocha/video_all/final_collection/123.mat')
      Q = cat(3,Q,MAP);
      %B=  [stsz styp maxp];
      P = cat(1,P,Z);

      
     
      
      save('/share/workhorse2/pmanocha/video_all/final_collection/123.mat','Q','P')
    else
        
       Q=MAP;
       P=Z;
       %E = cat(2,E,T);
       %E=  cat(2,stsz,styp,styp);
       save('/share/workhorse2/pmanocha/video_all/final_collection/123.mat','Q','P')
        
end
%save('/share/workhorse2/pmanocha/video_all/MAP_database/final_collection/123.mat','MAP','E')






end
