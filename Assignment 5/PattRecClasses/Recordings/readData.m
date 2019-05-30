format long
names = {'jackson', 'nicolas', 'theo', 'yweweler'};

data = cell(2000, 1);

count = 1;

for i=0:9
    for n=1:numel(names)
       for j=0:49
          file = [sprintf('%d_', i) names{n} sprintf('_%d', j) '.wav'];
          [data{count}.samples, data{count}.frequency] = audioread(file);
          currClass = zeros(10, 1);
          currClass(i + 1) = 1;
          data{count}.classOneHot = currClass;
          data{count}.classNum = i;
          data{count}.name = names{n};
          data{count}.sampleNum = j;
          data{count}.fileName = file;
          count = count + 1;
       end
    end
end

emil_data = cell(150, 1);

count = 1;
for i=0:9
    for j=1:25
        file = sprintf('%d_emil_%d.wav', i, j);
        [emil_data{count}.samples, emil_data{count}.frequency] = audioread(file);
        currClass = zeros(10, 1);
        currClass(i + 1) = 1;
        emil_data{count}.classOneHot = currClass;
        emil_data{count}.classNum = i;
        emil_data{count}.name = 'emil';
        emil_data{count}.sampleNum = j;
        emil_data{count}.fileName = file;
        count = count + 1;
    end
end