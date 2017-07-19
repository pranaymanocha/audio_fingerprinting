# audio_fingerprinting

For Running a task, use the bash script runall2.sh. It would call functions and all bash scripts separately. The first bash script that it calls is called
submit_script1.sh. It further call the matlab function helper.m and which further calls functions add_tracks.m and further to make a dictionary.


The code is divided into 3 sections:-
1) Database Creation
2) Query formation and evaluation
3) Result Consolidation


1) Database Creation:- involved use of files submit_script1.sh--> which calls opens matlab in command mode and runsa a matlab function helper.m, which calls functions add_tracks.m which subsequently adds tracks to a database.
 Currently each node processes only 800 files( creates database of 800 files).
 Inside the add_tracks.m, many separate functions like find_landmarks.m, landmarks2hash.m, record_hashes.m are there to record the hashes in a hashtable and store the resulting matrix in that name.
 
 
 2) Query formation:- uses functions submit_script2.sh and MAP_cal.m which takes 2 songs from the list of songs in the folder and another function, gen_random_hashes.m creates snippets and adds noise to these snippets.
 for each query, there are 5 levels of snippets and 4 levels of noise per snippet. So per Query song, we obtain a maximum of 20 queries.
 Another function match_query.m consolidates all the separate databases( created from all the entire database(which are stored in a single folder as separate names)) and runs a query match across them and finally displays a list of 
 the relevant top matches for the query. We then parse through the list and calculate the position of the correct song in the list and that is the Average Precision (1/t).
 For each query, the results are saved in a separate folder in another matlab file stacked one over the other.
 
 3) Result Consolidation:- done by submit_script4.sh and helper4.m. These functions consolidate the results and take the mean across all queries and calculate the MAP( Mean Average Procesion) for the entire set.
 
 4) File Deletion:- After the entire setup is followed, there are some files which need to be removed for redundancy. Those are there in submit_scipt5.sh.
 
 For running the code,
 
 1) Find the function runall2.sh, run the bash script ./runall2.sh. The code has some inbuilt addresses which I use( which will need to be modified) like the names of the err and log files, the final_result files and the MAP calcul/ation file
 s.
    
