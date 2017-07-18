function MAP_cal(stsz,styp,maxp)    

load( '/share/workhorse2/pmanocha/video_all/matlab_basis_yfcc_1.mat')
  % find all the MP3 files
%  dlist = dir(fullfile(dirname, '*.wav'));
%  x=size(dlist,1);
%  y = randsample(x,20000);
%  count=1;

% for i=1:size(y,1)
%    disp(dlist(y(i)).name)
%    fft_ms = 64;
%    fft_hop = 32;
%    targetSR=16000;
%    nfft = round(targetSR/1000*fft_ms);
%    S = abs(specgram(audioread(fullfile(dirname, dlist(y(i)).name)),nfft,targetSR,nfft,nfft-round(targetSR/1000*fft_hop)));
%    S1=S(1:513,:);
%    x=size(S1,2);
%    y1 = datasample(x,10);
%    for j=1:size(y1,1)
%        W(:,count)=S1(:,y1(j,1));
%        count=count+1;
%    end
%
% end





 data=PC2;
 param.K=str2double(stsz);
 param.numIteration=str2double(styp);
 param.preserveDCAtom=0;
 param.InitializationMethod='DataElements';
 param.displayProgress=1;
 param.L=str2double(maxp);


[D]=KSVD(data,param);
D1=normc(D);
A=OMP(D1,PC2,str2double(maxp));
A1=full(A);

C2=strcat('/share/workhorse2/pmanocha/',stsz,'.',styp,'.',maxp,'.mat');
save(C2,'A1')


start='1';

C=cell(2,1);
dirname1 = '/share/workhorse2/pmanocha/yfcc_wav_clipped_all';
  % find all the MP3 files
dlist1 = dir(fullfile(dirname1, '*.wav'));

   for  i=str2double(start):1+str2double(start)
       C{i-str2double(start)+1}=dlist1(i).name;
    end

Z=gen_random_queries(C);

%save('/share/workhorse2/pmanocha/video_all/Z_test.mat','Z')


%load('/share/workhorse2/pmanocha/video_all/queries.mat')

count_AP=zeros(4,5);
    count_items=zeros(4,5);
    
    for i=1:2
        for j=1:5
            for k=1:4
                if isempty(Z{i,j,k})==0 &&  all(Z{i,j,k})==1
                    try               
                      r=match_query(Z{i,j,k},16000,str2double(stsz),str2double(styp),str2double(maxp),(C2))
                      count_items(k,j)=count_items(k,j)+1;
                    if r(1,1)==0
                       chec=1;
                         for t=1:size(r,1)
                             if r(t,1)==str2double(start)+i-1
                              disp(t-1)
                              count_AP(k,j)=count_AP(k,j)+ (1./(t-1));
                              chec=chec+1;
                              break 
                             end
                          end
                         if chec==1
                         disp('not in the list') 
                        count_AP(k,j)=count_AP(k,j)+ 0.001;                       
                         end              
                    else
                       chec=1;
                         for t=1:size(r,1)
                             if r(t,1)==str2double(start)+i-1
                              disp(t)
                              count_AP(k,j)=count_AP(k,j)+ (1./(t));
                              chec=chec+1;
                               break        
                              end
                          end
                              if chec==1
                                disp('not in the list')
                                count_AP(k,j)=count_AP(k,j)+ 0.001;
                              end
                      end
                    end
                   
                end        
            end
        end
    end

    
zer=find(~count_items); 
count_items(zer)=1;  
MAP_right=count_AP ./ count_items;
disp(count_AP)
disp(count_items)
disp(MAP_right)
    if exist('/share/workhorse2/pmanocha/video_all/MAP_database/New_dataset_test_AA.mat', 'file') == 2
      load('/share/workhorse2/pmanocha/video_all/MAP_database/New_dataset_test_AA.mat')
      A = cat(3,A,MAP_right);
      B=  [str2num(stsz) str2num(styp) str2num(maxp)];
      E = cat(1,E,B);

      
      save('/share/workhorse2/pmanocha/video_all/MAP_database/New_dataset_test_AA.mat','A','E')
    else
        
       A=  MAP_right;
       E=  [str2double(stsz) str2double(styp) str2double(maxp)];
       %E = cat(2,E,T);
       %E=  cat(2,stsz,styp,styp);
       save('/share/workhorse2/pmanocha/video_all/MAP_database/New_dataset_test_AA.mat','A','E')
        
    end



 end
