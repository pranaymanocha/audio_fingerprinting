function helper3()

dirname = '/share/workhorse2/pmanocha/video_all/database';
dlist = dir(fullfile(dirname, '*.mat'));

C=[];
D=zeros;

for i=1:size(dlist,1)
   disp(i)
   load(fullfile(dirname, dlist(i).name))
   C=cat(1,C,HashTable);
   clear HashTable
   D=D+HashTableCounts;
   clear HashTableCounts
   if size(C,1)>2900
    W=[];
    count=1;
    while count<=size(C,2)
        disp(count)
        n = nnz(C(:,1));
        if n>1600
        s = nonzeros(C(:,1));
        y = randsample(n,1600);
        W(:,count) = s(y,:);
        elseif n<1600
        s = nonzeros(C(:,1));
        p=size(s,1);
        W(:,count)=[s;zeros(1600-p,1)];
        elseif n==1600
        s = nonzeros(C(:,1));
        W(:,count)=s;
        end
    C(:,1)=[];
    count=count+1;
    end
    
    clearvars C
      C=W;
    clearvars W

  end


end




 W=[];
    count=1;
    while count<=size(C,2)
        n = nnz(C(:,1));
        if n>1600
        s = nonzeros(C(:,1));
        y = randsample(n,1600);
        W(:,count) = s(y,:);
        elseif n<1600
        s = nonzeros(C(:,1));
        p=size(s,1);
        W(:,count)=[s;zeros(1600-p,1)];
        elseif n==1600
        s = nonzeros(C(:,1));
        W(:,count)=s;
        end
end
clearvars C

C=W;
clearvars W



HashTable=uint32(C);
clearvars C
HashTableCounts=D;
clearvars D
save('/share/workhorse2/pmanocha/video_all/Table_Database_new.mat','HashTable','HashTableCounts','-v7.3')

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
