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
 param.K=100;
 param.numIteration=20;
 param.preserveDCAtom=0;
 param.InitializationMethod='DataElements';
 param.displayProgress=1;
 param.L=100;
 
 
[D]=KSVD(data,param);
