format long
[female_sample_rate, female_frequency] = audioread('female.wav');
[music_sample_rate, music_requency] = audioread('male.wav');

figure;
subplot(1, 2, 1);

% The whole audio sample
plot(female_sample_rate);
hold on
title('Female audio signal');
xlabel('Sample');
ylabel('Momentary amplitude');
hold off
subplot(1, 2, 2);
plot(music_sample_rate);
hold on
title('Music audio signal');
xlabel('Sample');
ylabel('Momentary amplitude');
hold off


% Zoomed in on unvoiced speech signal 20ms
figure;
subplot(1, 2, 1);
plot(13000:13882, female_sample_rate(13000:13882));
hold on
title('Female audio signal');
xlabel('Sample');
ylabel('Momentary amplitude');
hold off
subplot(1, 2, 2);
plot(13000:13882, music_sample_rate(13000:13882));
hold on
title('Music audio signal');
xlabel('Sample');
ylabel('Momentary amplitude');
hold off

% Unvoiced signal patch
figure;
plot(20150:21210, female_sample_rate(20150:21210));
hold on
title('Unvoiced female speech segment');
xlabel('Sample');
ylabel('Momentary amplitude');
hold off

% Voiced signal patch
figure;
plot(12890:18640, female_sample_rate(12890:18640));
hold on
title('Voiced female speech segment')
xlabel('Sample');
ylabel('Momentary amplitude');
hold off