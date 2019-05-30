function [hNew,hGen]=testGMM1%test training a single GaussMixD object%for uneqeual MixWeight factors,%using manual initialization%Arne Leijon 2009-07-21 testedc='rbgk';%state color coding, max 4 states%make a simple Gaussmix distributionpDgen(1)=GaussD('Mean',[-3 0],'StDev',[1 3]);pDgen(2)=GaussD('Mean',[+3 0],'StDev',[1 3]);pDgen(3)=GaussD('Mean',[0 -3],'StDev',[3 1]);pDgen(4)=GaussD('Mean',[0 +3],'StDev',[3 1]);% pDgen(1)=GaussD([-7 0],[1 3]);% pDgen(2)=GaussD([+7 0],[1 3]);% pDgen(3)=GaussD([0 -7],[3 1]);% pDgen(4)=GaussD([0 +7],[3 1]);hGen=GaussMixD(pDgen,[3 3 1 1]);%Make a big training data sequence:[xTraining,sT]=rand(hGen,10000);%training datag=[GaussD('Mean',[-0.3 0],'StDev',[1 1]),GaussD('Mean',[+0.3 0],'StDev',[1 1]),...    GaussD('Mean',[0 -0.3],'StDev',[1 1]),GaussD('Mean',[0 +0.3],'StDev',[1 1])];hNew=GaussMixD(g);%hNew=init(GaussMixD(4),xTraining);%initialize??????????for nTraining=1:10    figure;    plotTraining(xTraining,sT,c);    %also plot error points, as classified by viterbi...    plotCross(hNew.Gaussians,[1 2],c); 	axis([-10 10 -10 10]);	hold off;%	pause;    %one training step:    aS=adaptStart(hNew);        aS=adaptAccum(hNew,aS,xTraining);    hNew=adaptSet(hNew,aS);end;mixWeight=hNew.MixWeight;display(mixWeight);%more smooth than original weights!!!function plotTraining(xT,sT,c)nStates=max(sT);for s=1:nStates    plot(xT(1,sT==s),xT(2,sT==s),['o',c(s)],'MarkerSize',1.5);    hold on;end;