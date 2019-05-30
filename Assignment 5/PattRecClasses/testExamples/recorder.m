format long 


file = '9_emil_%d.wav';
r = audiorecorder(22500, 16, 1);
for i=16:25
   disp('Start speaking');
   recordblocking(r, 2);
   disp('End of recording');
   stop(r);
   
   audiowrite(sprintf(file, i), getaudiodata(r), 22500);
end