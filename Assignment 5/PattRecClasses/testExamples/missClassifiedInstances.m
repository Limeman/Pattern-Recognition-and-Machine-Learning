format long

load('hmms.mat');
load('data.mat');

window_length = 30e-3;
ncep = 13;

confusion = zeros(10, 10);
wrong_instances = cell(size(hmms));
for i=0:9
   % Extract all elements from the current class
   tmp_data = [data{1 + i * 200:((i + 1) * 200)}];
   found_wrong = false;
   for j=1:numel(tmp_data)
       mfccs = GetSpeechFeatures(tmp_data(j).samples, tmp_data(j).frequency, window_length, ncep);
       mfccs = normalizeMFCCS(mfccs);
       probs = hmms.logprob(mfccs);
       
       [~, idx] = max(probs);
       
       if i + 1 ~= idx && ~found_wrong
           wrong_instances{i + 1} = mfccs;
           found_wrong = true;
       end
       
       confusion(i + 1, idx) = confusion(i + 1, idx) + 1;
       confusion(idx, i + 1) = confusion(idx, i + 1) + 1;
   end
   tmp = confusion(i + 1, :);
   tmp = tmp ./ sum(tmp);
   confusion(i + 1, :) = tmp;
   confusion(:, i + 1) = tmp;
end



figure;
imagesc(confusion);
title('Confusion matrix');

plotter(wrong_instances);

function plotter(instances)
    figure;
    for i=1:numel(instances)
        subplot(2, floor(numel(instances) / 2), i);
        imagesc(instances{i});
        title(sprintf('Class %d', i));
    end
end

function mfccs = normalizeMFCCS(mfccs)
    mu = mean(mfccs, 2);
    v = var(mfccs, 0, 2);
    mfccs = (mfccs - mu) ./ v;
end
