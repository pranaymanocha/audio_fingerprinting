function [R,L] = match_query(D,SR,IX,dens,f_sd,maxpairsperpeak,C2)
% [R,L] = match_query(D,SR,IX)
%     Match landmarks from an audio query against the database.
%     Rows of R are potential maxes, in format
%      songID  modalDTcount modalDT
%     i.e. there were <modalDTcount> occurrences of hashes 
%     that occurred in the query and reference with a difference of 
%     <modalDT> frames (of 32ms).  Positive <modalDT> means the
%     query matches after the start of the reference track.
%     L returns the actual landmarks that this implies for IX'th return.
%     as rows of <time in matching vid> f1 f2 dt <delay of query re
%     matching vid>
% 2008-12-29 Dan Ellis dpwe@ee.columbia.edu
C2=maxpairsperpeak;
maxpairsperpeak=f_sd;
f_sd=dens;
dens=IX;
if nargin < 6
  IX = 1;
end

if ischar(D)
  if nargin > 1
    IX = SR;
  end
  [D,SR] = readaudio(D);
end

% Target query landmark density
% (reference is 7 lm/s, query can be maybe 4x denser?)
%dens = 20;

% collapse stereo
if size(D,2) == 2
  D = mean(D,2);
end

%Rt = get_hash_hits(landmark2hash(find_landmarks(D,SR)));
Lq = find_landmarks(D,SR,dens,f_sd,maxpairsperpeak,C2);
%%Lq = fuzzify_landmarks(Lq);
% Augment with landmarks calculated half-a-window advanced too
landmarks_hopt = 0.032;
Lq = [Lq;find_landmarks(D(round(landmarks_hopt/4*SR):end),SR,dens,f_sd,maxpairsperpeak,C2)];
Lq = [Lq;find_landmarks(D(round(landmarks_hopt/2*SR):end),SR,dens,f_sd,maxpairsperpeak,C2)];
Lq = [Lq;find_landmarks(D(round(3*landmarks_hopt/4*SR):end),SR,dens,f_sd,maxpairsperpeak,C2)];

Hq = unique(landmark2hash(Lq), 'rows');
disp(['landmarks ',num2str(size(Lq,1)),' -> ', num2str(size(Hq,1)),' hashes']);
disp('gone')


dirname = '/share/workhorse2/pmanocha/video_all/database';
dlist = dir(fullfile(dirname, '*.mat'));
C=[];
for l=1:size(dlist,1)-287


	Rt = get_hash_hits(Hq,l);
	nr = size(Rt,1);
%disp(nr)

	if nr > 0

  % Find all the unique tracks referenced
  [utrks,xx] = unique(sort(Rt(:,1)),'first');
  utrkcounts = diff([xx',nr]);

  [utcvv,utcxx] = sort(utrkcounts, 'descend');
  % Keep at most 2000 per hit
 % disp(length(utcxx))
 utcxx = utcxx(1:min(2000,length(utcxx)));
  %utrkcounts = utrkcounts(utcxx);
  utrks = utrks(utcxx);
  
  nutrks = length(utrks);
  R = zeros(nutrks,4);

  	for i = 1:nutrks
    tkR = Rt(Rt(:,1)==utrks(i),:);
    % Find the most popular time offset
    [dts,xx] = unique(sort(tkR(:,2)),'first');
    dtcounts = 1+diff([xx',size(tkR,1)]);
    [vv,xx] = max(dtcounts);
    %    [vv,xx] = sort(dtcounts, 'descend');
    %R(i,:) = [utrks(i),vv(1),dts(xx(1)),size(tkR,1)];
    R(i,:) = [utrks(i),sum(abs(tkR(:,2)-dts(xx(1)))<=1),dts(xx(1)),size(tkR,1)];
  	end

  % Sort by descending match count
  [vv,xx] = sort(R(:,2),'descend');
  R = R(xx,:);

  % Extract the actual landmarks
  % maybe just those that match time?
  %H = Rt((Rt(:,1)==R(IX,1)) & (abs(Rt(:,2)-R(IX,3))<=1),:);
  % no, return them all
  %Hix = find(Rt(:,1)==R(IX,1));
  % Restore the original times
  %for i = 1:length(Hix)
  %  L(i,:) = [hash2landmark(Rt(Hix(i),:)), Rt(Hix(i),2)];
  %  hqix = find(Hq(:,3)==Rt(Hix(i),3));
  %  hqix = hqix(1);  % if more than one...
  %  L(i,1) = L(i,1)+Hq(hqix,2);
  %end


  % Return no more than 1000000 hits, and only down to 10% the #hits in
  % most popular
  % maxhits = R(1,2);
  % nuffhits = R(:,2)>(8);
   %R = R(nuffhits,:);
  maxrtns = 7;
  if size(R,1) > maxrtns
   R = R(1:maxrtns,:);
 end
 

  

	else
  R = zeros(0,4);
  disp('*** NO HITS FOUND ***');
	end
C=cat(1,C,R);
clearvars R

end

R1=C;
%disp(size(R1))i
[R] =(sortrows(R1,[-2]));
TF1=R(:,1)== 131071;
R(TF1,:)=[];
  maxhits = R(1,2);
  nuffhits = R(:,2)>(0.5*maxhits);
  R = R(nuffhits,:);



end
