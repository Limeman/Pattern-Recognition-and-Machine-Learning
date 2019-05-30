mc=MarkovChain([0.5;0.5], [0.97 0.03;0.04 0.96])%State generator
%mc=MarkovChain([0.5;0.5], [0.99 0.01;0.02 0.98]);%State generator
%mc=MarkovChain([0.5;0.5;0], [0.92 0.07 0.01;0.06 0.93 0.01]);% To verify the
%finite states.
g1=GaussD('Mean',0,'StDev',0.1) %Distribution for state=1
g2=GaussD('Mean',3,'StDev',0.2) %Distribution for state=2
g3=GaussD('Mean',0,'StDev',1)
h1=HMM(mc, [g1; g2]); %The HMM
h2=HMM(mc, [g1; g3]);
%[x,s]=rand(h1, 500); %Generate an output sequence with different means
%[y,s]=rand(h2, 500); %Generate an output sequence with same means
[x,s1]=rand(h1, 500); %Generate an output sequence with different means
[y,s2]=rand(h2, 500); %Generate an output sequence with same means

%subplot(1,2,1);
%plot(x);
%title('HMM behavior with different means');
%xlabel('T');
%ylabel('output samples');
%subplot(1,2,2);
%plot(y);
%title('HMM behavior with same means');
%xlabel('T');
%ylabel('output samples');
subplot(2,2,1);
plot(x);
title('Figure 1:HMM behavior with different means');
xlabel('T');
ylabel('Output samples X');
subplot(2,2,3);
plot(s1);
title('Figure 3:HMM state with different means');
xlabel('T');
ylabel('State samples S');

subplot(2,2,2);
plot(y);
title('Figure 2:HMM behavior with same means');
xlabel('T');
ylabel('Output samples X');
subplot(2,2,4);
plot(s2);
title('Figure 4:HMM state with same means');
xlabel('T');
ylabel('State samples S');



