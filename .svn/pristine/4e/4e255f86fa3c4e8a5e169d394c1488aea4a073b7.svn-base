mc=MarkovChain([0.75;0.25], [0.99 0.01;0.03 0.97]);%State generator
g1=GaussD('Mean',0,'StDev',1); %Distribution for state=1
g2=GaussD('Mean',3,'StDev',2); %Distribution for state=2
h=HMM(mc, [g1; g2]); %The HMM
[x,s]=h.rand(10000);%Generate an output sequence

%verify markov chain
S=mc.rand(10000);%Generate an state sequence
count1=0;
count2=0;
for i=1:length(S)
    if S(i)==1
        count1=count1+1;
    else
        count2=count2+1;
    end
end
f1=(count1/length(S))*100   %relative frequency of occurrences of St = 1 and St = 2.
f2=(count2/length(S))*100
% f1 and f2 are approximation of P(S=1) and P(S=2)
%verify hmm
 m=mean(x)
 v=var(x)
% m and v are approximation of u(x) and var(x)
