nStates=3;
A=[.95 .03 .02; .03 .95 .02;.03 0.02 0.95];
p0=[1;1;1];
mc=MarkovChain(p0,A);

%pDgen(1)=GaussD('Mean',[0 0],'StDev',[3 1]);
%pDgen(2)=GaussD('Mean',[+1 0],'StDev',[1 3]);
%pDgen(3)=GaussD('Mean',[-1 0],'StDev',[1 3]);

pDgen(1)=GaussD('Mean',[0 0],'Covariance',[2 1;1 4]);
pDgen(2)=GaussD('Mean',[10 10],'Covariance',[2 1;1 4]);
pDgen(3)=GaussD('Mean',[-10 -10],'Covariance',[2 1;1 4]);

%hGen=HMM('MarkovChain',mc,'OutputDistr',pDgen);
hGen=HMM(mc,pDgen);
[X,S]=rand(hGen,10000);%each output samples will have two elements
plot(X(:,1),X(:,2),'*')
grid on
title('Vector distribution of observation X')
xlabel('X1');ylabel('X2')