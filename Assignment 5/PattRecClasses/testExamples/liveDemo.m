format long

%load('hmms.mat');
load('hmms_emil.mat');
window_length = 30e-3;
ncep = 13;

r = audiorecorder(22500, 16, 1);
disp('Start speaking');
recordblocking(r, 2);
disp('End of recording');
stop(r);
p = play(r);

audiodata = getaudiodata(r);


[mfccs, spetgram, f, t] = GetSpeechFeatures(audiodata, 22500, window_length, ncep);
mfccs = normalizeMFCCS(mfccs);

%probs = hmms.logprob(mfccs);
probs = hmms_emil.logprob(mfccs);

[~, choice] = max(probs);

choice - 1

function mfccs = normalizeMFCCS(mfccs)
    mu = mean(mfccs, 2);
    v = var(mfccs, 0, 2);
    mfccs = (mfccs - mu) ./ v;
end