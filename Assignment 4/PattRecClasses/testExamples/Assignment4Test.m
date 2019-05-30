format long
clear

% Observations
x = [-0.2 2.6 1.3];

% Infinite
%mc = MarkovChain([0.75; 0.25], [0.99 0.01; 0.03 0.97]);
% Finite
mc = MarkovChain([1; 0], [0.9 0.1 0; 0 0.9 0.1]);
g1 = GaussD('Mean', 0, 'StDev', 1);
g2 = GaussD('Mean', 3, 'StDev', 2);

pX = prob([g1, g2], x);

% Calculate c with the forward pass
%[~, c] = mc.forward(pX);

% Use the rounded 4 decimal point version of c (only for finite duration)
c = [1.0000, 0.1625, 0.8266, 0.0581];

betaHat = mc.backward(pX, c)