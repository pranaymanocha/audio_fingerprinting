function [N,T] = add_tracks(D,SR,ID,dens,f_sd,maxpairsperpeak,start)
% [N,T] = add_tracks(D,SR,ID)
%    Add one or more tracks to the hashtable database.
%    <D, SR> define the waveform of the track, and ID is its
%    reference ID.
%  add_tracks(N,ID) loads soundfile named N and adds it.
%  add_tracks(A,IDs,skip) loads each soundfile named in 
%    cell array A and adds it with the corresponding element 
%    from IDs (pass [] to use index number as ID).  Optional 
%    skip causes adding to start only from the skip+1th element.
%
%    N returns the total number of hashes added, T returns total
%    duration in secs of tracks added.

% global count=0;
% 
% % for iteration 1
%   if count==0
%       
%   dirname = '/share/workhorse2/pmanocha/video_qsub_test_new';
%   % find all the MP3 files
%   dlist = dir(fullfile(dirname, '*.wav'));
%   % put their full paths into a cell array
%   tks = []; 
%   for i = 1:length(dlist)
%     tks{i} = fullfile(dirname, dlist(i).name); 
%   end
%   D=tks;
%   else
%       count=count+1;
%   end
 
  
if isnumeric(D)
  H = landmark2hash(find_landmarks(D,SR,dens,f_sd,maxpairsperpeak),ID);
  record_hashes(H);
  N = length(H);
  T = length(D)/SR;
elseif ischar(D)
    %disp(nargin)
    %disp(SR)
      if nargin < 7
        start=maxpairsperpeak;
        maxpairsperpeak=f_sd;
        f_sd=dens;
        dens=ID;
        ID = SR;
      end
  try
    [D,SR] = readaudio(D);
    [N,T] = add_tracks(D,SR,ID,dens,f_sd,maxpairsperpeak,start);
  catch
    return
  end
   % [N,T] = add_tracks(D,SR,ID,dens,f_sd,maxpairsperpeak,start);

  elseif iscell(D)
         start=f_sd;
  maxpairsperpeak=dens;
  f_sd=ID;
  dens=SR;
  %disp(dens)
  %disp(num2str(dens))
  disp(['Target density = ',num2str(dens),' hashes/sec']);
  
  nd = length(D);
  if nargin < 6
    skip = 0;
  else
    skip = ID;
  end
  if nargin < 6
    % simulate user entering "don't care" for IDs
    SR = [];
  end
  if length(SR) == 0
    %omitting IDs defaults to track number
    ID = start:start+nd-1;
  else
    % ID is second arg
    ID = SR;
  end
  N = 0;
  T = 0;
  for i = (skip+1):nd
    disp(['Adding #',num2str(ID(i)),' ',D{i},' ...']);
    [n,t] = add_tracks(D{i},ID(i),dens,f_sd,maxpairsperpeak,start);
    N = N + n;
    T = T + t;
  end
global HashTable HashTableCounts
C=strcat('/share/workhorse2/pmanocha/video_all/database/',num2str(start),'.mat');
save(C,'HashTable','HashTableCounts')

  disp(['added ',num2str(nd),' tracks (',num2str(T),' secs, ', ...
        num2str(N),' hashes, ',num2str(N/T),' hashes/sec)']);
else
  error('I cant tell what D is');
end

