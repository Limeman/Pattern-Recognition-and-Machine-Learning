A=[.95 .03 .01 .01; .03 .75 .20 .02;.03 .02 .75 .20 ]; %3 by 4 transtion matrix; state 4 is end state
p0=[1;1;1];
mc=MarkovChain(p0,A);
S=rand(mc,20);
g1=GaussD('Mean',0,'StDev',1); %Distribution for state=1
g2=GaussD('Mean',3,'StDev',2); %Distribution for state=2
g3=GaussD('Mean',1,'StDev',2); %Distribution for state=3
h=HMM(mc, [g1; g2; g3]); %The HMM
[x,s]=h.rand(500);%Generate an output sequence
length(s)