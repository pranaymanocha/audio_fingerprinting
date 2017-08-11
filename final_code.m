function final_code(stsz,styp,maxp,audio_file_path)

r=match_query(audioread(audio_file_path),16000,stsz,styp,maxp);
disp(r)

end