function helper8()
%PCA1: Perform PCA using covariance.
% data - MxN matrix of input data
% (M dimensions, N trials)
% signals - MxN matrix of projected data
% PC - each column is a PC:w
% V - Mx1 matrix of variances
%data=C;

%for i=1:size(data,1)


  dirname = '/share/workhorse2/pmanocha/yfcc_wav_clipped_all';
  % find all the MP3 files
  dlist = dir(fullfile(dirname, '*.wav'));
  x=size(dlist,1);
  y = randsample(x,200000);
  
  count=1;

 for i=1:size(y,1)
%i=21;
    disp(dlist(y(i)).name)
    fft_ms = 64;
    fft_hop = 32;
    targetSR=16000;
    nfft = round(targetSR/1000*fft_ms);
    S = abs(specgram(audioread(fullfile(dirname, dlist(y(i)).name)),nfft,targetSR,nfft,nfft-round(targetSR/1000*fft_hop)));
    S1=S(1:513,:);
    x=size(S1,2);
    y1 = datasample(x,10);
    for j=1:size(y1,1)
        W(:,count)=S1(:,y1(j,1));
        count=count+1;
    end
        
  end   


data=W; 
[M,N] = size(data);
%a=min(M,N);
% subtract off the mean for each dimension
mn = mean(data,2);
data1 = data - repmat(mn,1,N);
% calculate the covariance matrix
covariance = 1 / (N-1) * data1 * data1';
a=size(covariance,1);
% find the eigenvectors and eigenvalues
[PC, V] = eig(covariance);
% extract diagonal of matrix as vector
V = diag(V);
% sort the variances in decreasing order
[junk, rindices] = sort(-1*V);
error_normal=1;

while a>=1
    %V = V(rindices);
    PC = PC(:,rindices);
    PC1=PC(:,1:a);
    % project the original data set
    signals = PC1'* data1;
    approximated=PC1 * signals;
    error=data1-approximated;
    n=norm(error,'fro');
    if n<=error_normal
       swp=a;    
       swp_error=n; 
       error_normal=n;
       disp(a)
       disp(error_normal)
    else
        disp(a)
    end
    a=a-1;
end

PC2=PC(:,1:swp);

save('/share/workhorse2/pmanocha/video_all/matlab_basis_yfcc_1.mat','PC2','swp','swp_error')
end




% V = V(rindices);
% PC = PC(:,rindices);
% % project the original data set
% signals = PC'* data1;
% approximated=PC * signals;
% error=data1-approximated;
% n=norm(error,'fro');

%end

