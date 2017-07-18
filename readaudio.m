function [D, SR] = readaudio(FN)
% [D, SR] = readaudio(FN)
%   Read in an audio file, using wavread, mp3read, or m4aread as
%   appropriate. 
% 2010-09-16 Dan Ellis dpwe@ee.columbia.edu

[pth,nam,ext] = fileparts(FN);
ext = lower(ext);
if strcmp(ext,'.mp3')
  [D,SR] = audioread(FN);
elseif strcmp(ext, '.m4a') || strcmp(ext, '.aac')
  [D,SR] = audioread(FN);
else
  [D,SR] = audioread(FN);
end
