format long


% hyperparameters
ncep = 13;
window_length = 30e-3;

% Initialize HMMs
num_hidden_state = [6;5;4;5;5;5;6;7;4;5];
trans_to_next_state = [1/5; 1/5; 1/6; 1/4; 1/5; 1/5; 1/4; 1/4; 1/6; 1/6];

% For the given dataset
%{

% Load the data
load('data.mat');

[trainSet, testSet] = partitionData(data);

for i=1:10
    A = initTransMatrix(trans_to_next_state(i), num_hidden_state(i));
    q = zeros(num_hidden_state(i), 1);
    q(1) = 1;
    clear mu
    clear v
    clear pD
    mu = zeros(ncep, 1);
    v = ones(ncep, 1);

    g = GaussD('Mean', mu, 'StDev', v);

    pD(1) = GaussMixD([g g g]);
   
    for j=2:num_hidden_state(i)
        mu_tmp = mu + random('normal', 0, 0.01, [ncep, 1]);
        v_tmp = v + random('normal', 0, 0.01, [ncep, 1]);
        g = GaussD('Mean', mu_tmp, 'StDev', v_tmp);
        pD(j) = GaussMixD([g g g]);
    end
    
    B = pD;
    
    mc = MarkovChain(q, A);
    
    hmms(i) = HMM(mc, B);
end

for i=0:9
    [mfccs, idx] = getMFCCS(data, i, window_length, ncep);
    [hmms(i + 1), logprobs] = hmms(i + 1).train(mfccs, idx);
end

count = 1;
accuracy = zeros(10, 1);

for c=0:9
    idx = zeros(20, 1);
    count = 1;
    for i=20*c + 1:20*(c + 1)
       mfccs = GetSpeechFeatures(testSet{i}.samples, testSet{i}.frequency, window_length, ncep);

       mfccs = normalizeMFCCS(mfccs);

       probs = hmms.logprob(mfccs);

       [~, idx(count)] = max(probs) ;
       count = count + 1;
    end
    accuracy(c + 1) = sum(idx==c + 1) ./ numel(idx);
end
accuracy

%}


% For the inhouse dataset
%%{
% Load the data
load('emil_data.mat');

for i=1:10
    A = initTransMatrix(trans_to_next_state(i), num_hidden_state(i));
    q = zeros(num_hidden_state(i), 1);
    q(1) = 1;
    clear mu
    clear v
    clear pD
    mu = zeros(ncep, 1);
    v = ones(ncep, 1);

    g = GaussD('Mean', mu, 'StDev', v);

    pD(1) = GaussMixD([g g g]);
   
    for j=2:num_hidden_state(i)
        mu_tmp = mu + random('normal', 0, 0.01, [ncep, 1]);
        v_tmp = v + random('normal', 0, 0.01, [ncep, 1]);
        g = GaussD('Mean', mu_tmp, 'StDev', v_tmp);
        pD(j) = GaussMixD([g g g]);
    end
    
    B = pD;
    
    mc = MarkovChain(q, A);
    
    hmms_emil(i) = HMM(mc, B);
end

for i=0:9
    [mfccs, idx] = getMFCCS(data, i, window_length, ncep);
    [hmms_emil(i + 1), logprobs] = hmms_emil(i + 1).train(mfccs, idx);
end
%}

function [big_mfccs, idx] = getMFCCS(data, class, window_length, ncep)
    big_mfccs = [];
    idx = [];
    for i=1:numel(data)
        if data{i}.classNum == class
            mfccs = GetSpeechFeatures(data{i}.samples, data{i}.frequency, window_length, ncep);
            mfccs = normalizeMFCCS(mfccs);
            big_mfccs = [big_mfccs mfccs];
            idx = [idx size(mfccs, 2)];
        end
    end
end

function A = initTransMatrix(prob, divider)
    A = [eye(divider) * (1 - prob), zeros(divider, 1)];
    for i=1:divider
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