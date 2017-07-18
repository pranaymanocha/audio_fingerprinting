function [Q,SR] = gen_random_queries(IDs,Seed)
% [Q,SR] = gen_random_queries(IDs,Dur,Noise,Seed)
%    Generate a cell array of random queries for testing the
%    fingerprinter.  IDs is a cell array of ID strings to 
%    indicate the files.  Dur is the duration of the excerpt to 
%    randomly pull from the file.  Noise is a level of noise 
%    to add (0 => no noise).  Return Q as a cell array of 
%    waveforms, one for each entry in IDs, that can be passed to
%    eval_fprint.m. 
%    Optional Seed will initialize RNG to a fixed point.
% 2010-04-21 DAn Ellis dpwe@ee.columbia.edu
%IDs=C;
nIDs = length(IDs);

%prepend = '';
postpend = '';

SR = 0;


if nargin > 3
  rns = RandStream.create('mt19937ar','seed',Seed);
  RandStream.setDefaultStream(rns);
end

for i = 1:length(IDs)
  %i=1;
  id = IDs{i};
  fname = ['/share/workhorse2/pmanocha/yfcc_wav_clipped_all/',id,postpend];
  [pth,nm,ext] = fileparts(fname);
  if strcmp(ext,'.wav') == 1
    [d,sr] = audioread(fname);
    time=length(d)/sr ;
    %disp(time);
  end
  if size(d,2) == 2
    % convert to mono if stereo
    d = mean(d,2);
  end
  % choose random excerpt
  ld = length(d);
  snippets=[1,5,10,15,30];
  snr=[0,5,10,20];
  for j=1:5
%j=3;
  qlen = round(snippets(j)* sr);
 % disp(i);
    if(ld-qlen)>=0
      disp(j)
    sp = round((ld - qlen)*rand(1));
    %disp(j);
    %Q{i,j} = d(sp + [1:qlen]);
        for k=1:4
            %k=1;
            Npts = length(d(sp + [1:qlen])); % Number of input time samples
            Noise = randn(1,Npts); % Generate initial noise; mean zero, variance one
            Noise_Power=sum(abs(Noise).*abs(Noise));
            Signal_Power = sum(abs(d(sp + [1:qlen])).*abs(d(sp + [1:qlen])));
            K = (Signal_Power/Noise_Power)*10^(-snr(k)/10);
            New_Noise = sqrt(K)*Noise;
            Noise_Power=sum(abs(New_Noise).*abs(New_Noise));
            Initial_SNR = 10*(log10(Signal_Power./Noise_Power));
            %disp(Initial_SNR)
            Q{i,j,k}=d(sp + [1:qlen]) + New_Noise';
            %Z= d(sp + [1:qlen]) + New_Noise';
            %awgn(d(sp + [1:qlen]),snr(k));     
     
   end
  else
for p=1:4 
   Q{i,j,p}=[];
end    
end

  end
  if SR == 0
    SR = sr;
  elseif SR ~= sr
    error(['File ',fname,' has sr ',num2str(sr),' not ', num2str(SR)]);
  end
  %save('snippets&noise_try2.mat','Q');
end

  
