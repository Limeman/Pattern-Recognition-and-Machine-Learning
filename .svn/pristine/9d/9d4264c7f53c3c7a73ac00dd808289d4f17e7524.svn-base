format long

% Read in the audio files
[female_samples, female_frequency] = audioread('female.wav');
[male_samples, male_frequency] = audioread('male.wav');
[music_samples, music_frequency] = audioread('music.wav');

ncep = 13;
window_length = 30e-3;

% Getting speech features
[female_mfccs, female_spetgram, female_f, female_t] = GetSpeechFeatures(female_samples, female_frequency, window_length, ncep);
[male_mfccs, male_spetgram, male_f, male_t] = GetSpeechFeatures(male_samples, male_frequency, window_length, ncep);
[music_mfccs, music_spetgram, music_f, music_t] = GetSpeechFeatures(music_samples, music_frequency, window_length, ncep);

% Normalize of mfccs's
mu = mean(female_mfccs, 2);
v = var(female_mfccs, 0, 2);
female_mfccs = (female_mfccs - mu) ./ v;

mu = mean(music_mfccs, 2);
v = var(music_mfccs, 0, 2);
music_mfccs = (music_mfccs - mu) ./ v;

mu = mean(male_mfccs, 2);
v = var(male_mfccs, 0, 2);
male_mfccs = (male_mfccs - mu) ./ v;

% loging of spectrograms
female_spetgram = log(female_spetgram);
male_spetgram = log(male_spetgram);
music_spetgram = log(music_spetgram);

% Calculation of correlation between images
speech_spetgram_corr = abs(corr(female_spetgram, male_spetgram));
speech_cepgram_corr = abs(corr(female_mfccs, male_mfccs));

% Extraction of dynamic features
dyn_female_cepgram = zeros(ncep * 3, size(female_mfccs, 2));
dyn_female_cepgram(1:ncep, :) = female_mfccs;
dyn_female_cepgram(ncep + 1 : 2 * ncep, 1) = zeros(ncep, 1);
dyn_female_cepgram(ncep + 1: 2 * ncep, 2:end) = diff(female_mfccs, 1, 2);
dyn_female_cepgram(2 * ncep + 1: end, 1) = zeros(ncep, 1);
dyn_female_cepgram(2 * ncep + 1 : end, 3:end) = diff(female_mfccs, 2, 2);

dyn_male_cepgram = zeros(ncep * 3, size(male_mfccs, 2));
dyn_male_cepgram(1:ncep, :) = male_mfccs;
dyn_male_cepgram(ncep + 1 : 2 * ncep, 1) = zeros(ncep, 1);
dyn_male_cepgram(ncep + 1: 2 * ncep, 2:end) = diff(male_mfccs, 1, 2);
dyn_male_cepgram(2 * ncep + 1: end, 1) = zeros(ncep, 1);
dyn_male_cepgram(2 * ncep + 1 : end, 3:end) = diff(male_mfccs, 2, 2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Plotter for spectrgrams                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open/close spectrogram visualizer here
%{
figure;
subplot(1, 2, 1);
imagesc(female_spetgram);
hold on
title('Spectrogram of female audio signal');
xlabel('Timeframe');
ylabel('Frequency');
colorbar;
hold off
subplot(1, 2, 2);
imagesc(music_spetgram);
hold on
title('Spectrogram of music audio signal');
xlabel('Timeframe');
ylabel('Frequency');
colorbar;
hold off
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   End of Plotter for spectrgrams                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Plotter for cepstrogram vs spectrogram                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open/close cepstrogram visualizer here
%%{

figure;
subplot(1, 2, 1);
imagesc(female_spetgram);
hold on
title('Spectrogram of female audio signal');
xlabel('Timeframe');
ylabel('Frequency');
colorbar;
hold off
subplot(1,2,2);
imagesc(female_mfccs);
colorbar;
hold on
title('Cepstrogram of female audio signal');
xlabel('Timeframe');
ylabel('Cepstrum frames');
hold off

figure;
subplot(1, 2, 1);
imagesc(music_spetgram);
hold on
title('Spectrogram of music audio signal');
xlabel('Timeframe');
ylabel('Frequency');
colorbar;
hold off
subplot(1, 2, 2);
imagesc(music_mfccs);
colorbar;
hold on
title('Cepstrogram of music audio signal');
xlabel('Timeframe');
ylabel('Cepstrum frames');
hold off

figure;
subplot(1, 2, 1);
imagesc(female_mfccs);
hold on
title('Cepstrogram of female audio signal');
xlabel('Timeframe');
ylabel('Cepstrum frames');
colorbar;
hold off
subplot(1,2,2);
imagesc(male_mfccs);
colorbar;
hold on
title('Cepstrogram of male audio signal');
xlabel('Timeframe');
ylabel('Cepstrum frames');
hold off

figure;
subplot(1, 2, 1);
imagesc(female_spetgram);
hold on
title('Logged Spectrogram of female audio signal');
xlabel('Timeframe');
ylabel('Frequency');
colorbar;
hold off
subplot(1,2,2);
imagesc(male_spetgram);
colorbar;
hold on
title('Logged Spectrogram of male audio signal');
xlabel('Timeframe');
ylabel('Frequency');
hold off

figure;
imagesc(speech_spetgram_corr);
colormap gray;
colorbar;
hold on
title('Correlation matrices between male and female spectrograms');
ylabel('Frequency');
xlabel('Timeframe');
hold off

figure;
imagesc(speech_cepgram_corr);
colormap gray;
colorbar;
hold on
title('Correlation matrices between male and female cepstrograms');
ylabel('Frequency');
xlabel('Timeframe');
hold off
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                End of Plotter for cepstrogram vs spectrogram            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%