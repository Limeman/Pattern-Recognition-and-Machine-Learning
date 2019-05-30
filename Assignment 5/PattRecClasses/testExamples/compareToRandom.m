format long

load('hmms.mat');
load('data.mat');

[train_data, ~] = partitionData(data);

window_length = 30e-3;
ncep = 13;

%%{
rand_out_seq = cell(size(hmms));
class_example = cell(size(hmms));
for i=1:numel(hmms)
    for j=1:100
        if j == 1
            rand_out_seq{i} = hmms(i).rand(1000);
            continue
        end
        tmp = hmms(i).rand(1000);
        if size(tmp, 2) > size(rand_out_seq{i}, 2)
            rand_out_seq{i} = [rand_out_seq{i} zeros(ncep, size(tmp, 2) - size(rand_out_seq{i}, 2))];
        elseif size(tmp, 2) < size(rand_out_seq{i}, 2)
            tmp = [tmp zeros(ncep, size(rand_out_seq{i}, 2) - size(tmp, 2))];
        end
        rand_out_seq{i} = rand_out_seq{i} + tmp;
    end
    rand_out_seq{i} = rand_out_seq{i} ./ 100;
    %class_example{i} = getFromClass(train_data, i - 1, 1, window_length, ncep);
    class_example{i} = AvgMFCCS(train_data, i - 1, window_length, ncep);
end
%}


for i=1:numel(hmms)
    plotter(rand_out_seq{i}, class_example{i}, 'Randomized observation sequence from HMM', ...
        'Average observation sequence across class in training set', 'Timeframe'...
        , 'Frequency');
end


function plotter(data1, data2, title_1, title_2, x_label, y_label)
    figure;
    subplot(1, 2, 1);
    imagesc(data1);
    title(title_1);
    xlabel(x_label);
    ylabel(y_label);
    subplot(1, 2, 2);
    imagesc(data2);
    title(title_2);
    xlabel(x_label);
    ylabel(y_label);
end

function mfccs = getFromClass(data, class, index, window_length, ncep)
    curr_ind = 1;
    for i=1:numel(data)
        if data{i}.classNum == class
            if curr_ind == index
               mfccs = GetSpeechFeatures(data{i}.samples, data{i}.frequency, window_length, ncep);
               mfccs = normalizeMFCCS(mfccs);
               break;
            end
            curr_ind = curr_ind + 1;
        end
    end
end

function mfccs = normalizeMFCCS(mfccs)
    mu = mean(mfccs, 2);
    v = var(mfccs, 0, 2);
    mfccs = (mfccs - mu) ./ v;
end

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