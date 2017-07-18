function helper(stsz,styp,maxp,start)

  dirname = '/share/workhorse2/pmanocha/yfcc_wav_clipped_all';
  dlist = dir(fullfile(dirname, '*.wav'));
  tks = []; 
  for i = str2double(start):str2double(start)+800-1
    tks{i-str2double(start)+1} = fullfile(dirname, dlist(i).name); 
  end
  clear_hashtable
  add_tracks(tks,str2double(stsz),str2double(styp),str2double(maxp),str2double(start));
  
end
