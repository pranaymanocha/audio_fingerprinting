function helper10()

dirname = '/share/workhorse2/pmanocha/video_all/database';
dlist = dir(fullfile(dirname, '*.mat'));

C=[];
D=zeros;

for i=1:size(dlist,1)

   disp(i)
   load(fullfile(dirname, dlist(i).name))
   A(:,:,i)=HashTable;
   D=D+HashTableCounts;
   clearvars HashTable HashTableCounts

end


HashTable=A;
HashTableCounts=D;
save('/share/workhorse2/pmanocha/video_all/successful.mat','HashTable','HashTableCounts','-v7.3')
%C=cell(50,1);
%dirname1 = '/share/workhorse2/pmanocha/wav_audio';
  % find all the MP3 files
%dlist1 = dir(fullfile(dirname1, '*.wav'));

%    for i=1:50
%       C{i}=dlist1(i).name;  
%    end

%Z=gen_random_queries(C);
%save('/share/workhorse2/pmanocha/video_all/queries.mat','Z')

end
