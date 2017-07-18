function helper2(stsz,styp,maxp,start)

dirname = '/share/workhorse2/pmanocha/video_all/database';
% find all the MP3 files
dlist = dir(fullfile(dirname, '*.mat'));

C=[];
D=zeros;

for i=1:size(dlist,1)
   load(fullfile(dirname, dlist(i).name))
   C=cat(1,C,HashTable);
   clear HashTable
   D=D+HashTableCounts;
   clear HashTableCounts
end


W=[];
for i=1:size(C,2)
   n = nnz(C(:,i));
    if n>40
        W(:,i) = randsample(C(:,i),40);
    elseif n<40
       s = nonzeros(C(:,i));
       p=size(s,1);       
       W(:,i)=[s;zeros(40-p,1)]; 
    elseif n==40
        s = nonzeros(C(:,i));
        W(:,i)=nonzeros(C(:,i));
    end
end

HashTable=W;
HashTableCounts=D;
save('/share/workhorse2/pmanocha/video_all/Table_Database.mat','HashTable','HashTableCounts')

C=cell(50,1);
dirname1 = '/share/workhorse2/pmanocha/wav_audio';
  % find all the MP3 files
dlist1 = dir(fullfile(dirname1, '*.wav'));

    for i=1:50
       C{i}=dlist1(i).name;  
    end

Z=gen_random_queries(C);

MAP_cal(Z,str2double(stsz),str2double(styp),str2double(maxp),str2double(start))



end
