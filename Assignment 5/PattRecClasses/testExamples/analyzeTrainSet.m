format long
clear

% hyperparameters
ncep = 13;
window_length = 30e-3;



% Load the data
load('data.mat');

[trainSet, testSet] = partitionData(data);

% Calculate the average number of emissions for each class (number)
avgs = averageSeqLen(trainSet, 180, window_length, ncep);

divider = zeros(10, 1);

% Calculate the expected transition probs to the next state, each class
% will have n phonemes and two silent states in the beginning and the end
% for zero, there will be 6 hidden states http://www.speech.cs.cmu.edu/cgi-bin/cmudict?in=zero
divider(1) = 6;

% for one there will be 5 hidden states http://www.speech.cs.cmu.edu/cgi-bin/cmudict?in=one
divider(2) = 5;

% for two there will be 4 hidden states http://www.speech.cs.cmu.edu/cgi-bin/cmudict?in=two
divider(3) = 4;

% for three there will be 5 hidden states http://www.speech.cs.cmu.edu/cgi-bin/cmudict?in=three
divider(4) = 5;

% for four there will be 5 hidden states http://www.speech.cs.cmu.edu/cgi-bin/cmudict?in=four
divider(5) = 5;

% for five there will be 5 hidden states http://www.speech.cs.cmu.edu/cgi-bin/cmudict?in=five
divider(6) = 5;

% for six there will be 6 hidden states http://www.speech.cs.cmu.edu/cgi-bin/cmudict?in=six
divider(7) = 6;

% for seven there will be 7 hidden states http://www.speech.cs.cmu.edu/cgi-bin/cmudict?in=seven
divider(8) = 7;

% for eight there will be 4 hidden states http://www.speech.cs.cmu.edu/cgi-bin/cmudict?in=eight
divider(9) = 4;


% for nine there will be 5 hidden states http://www.speech.cs.cmu.edu/cgi-bin/cmudict?in=nine
divider(10) = 5;

% Calculate the average expected number of time steps each hidden state
% will be generating emissions

avgs = avgs ./ divider;

% Which gave
% avgs =
% 
%    5.024999999999999
%    4.720000000000001
%    5.601388888888889
%    4.363333333333333
%    4.587777777777778
%    5.288888888888889
%    4.462962962962963
%    3.730952380952381
%    5.900000000000000
%    6.217777777777778

% Which gives the expected probability of transitioning to the next state

avgs = round(avgs);
avgs = 1 ./ avgs;

% avgs =
% 
%    0.200000000000000
%    0.200000000000000
%    0.166666666666667
%    0.250000000000000
%    0.200000000000000
%    0.200000000000000
%    0.250000000000000
%    0.250000000000000
%    0.166666666666667
%    0.166666666666667

A = initTransMatrix(avgs(1), divider(1));

avg_mfccs = AvgMFCCS(trainSet, 9, window_length, ncep);

imagesc(avg_mfccs)

function avg_mfccs = AvgMFCCS(data, class, window_length, ncep)
    max = GetMaxLen(data, class, window_length, ncep);
    avg_mfccs = zeros(ncep, max);
    count = 0;
    for i=1:numel(data)
        if data{i}.classNum == class
            tmp_mfccs = GetSpeechFeatures(data{i}.samples, data{i}.frequency, window_length, ncep);
            tmp_mfccs = normalizeMFCCS(tmp_mfccs);
            tmp = size(tmp_mfccs, 2);
            if tmp < max
                tmp_mfccs = [tmp_mfccs zeros(ncep, max - tmp)];
            end
            avg_mfccs = avg_mfccs + tmp_mfccs;
            count = count + 1;
        end
    end
    avg_mfccs = avg_mfccs ./ count;
end

function max = GetMaxLen(data, class, window_length, ncep)
    max = -Inf;
    for i=1:numel(data)
        if data{i}.classNum == class
            tmp_mfccs = GetSpeechFeatures(data{i}.samples, data{i}.frequency, window_length, ncep);
            tmp_mfccs = normalizeMFCCS(tmp_mfccs);
            tmp = size(tmp_mfccs, 2);
            if tmp > max
                max = tmp;
            end
        end
    end
end

function A = initTransMatrix(prob, divider)
    A = [eye(divider - 1) * (1 - prob), zeros(divider - 1, 1)];
    for i=1:divider - 1
        A(i, i + 1) = prob;
    end
end

function avgs = averageSeqLen(data, n_in_class, window_length, ncep)
    avgs = zeros(10, 1);
    for i=1:n_in_class:numel(data)
        for j=0:n_in_class - 1
            [mfccs, ~, ~, ~] = GetSpeechFeatures(data{i + j}.samples, data{i + j}.frequency, window_length, ncep);
            avgs = avgs + data{i + j}.classOneHot .* size(mfccs, 2);
        end
    end
    avgs = avgs ./ n_in_class;
end

function mfccs = normalizeMFCCS(mfccs)
    mu = mean(mfccs, 2);
    v = var(mfccs, 0, 2);
    mfccs = (mfccs - mu) ./ v;

end

function [trainSet, testSet] = partitionData(data)
    testSet = cell(200, 1);
    trainSet = cell(1800, 1);
    testCount = 1;
    trainCount = 1;
    for i=1:50:2000
        for t = 0:4
            testSet{testCount} = data{i + t};
            testCount = testCount + 1;
        end
        for t = 5:49
            trainSet{trainCount} = data{i + t};
            trainCount = trainCount + 1;
        end
    end
end