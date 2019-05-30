format long

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Testing of forward pass                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open/close Testing of forward pass here
%{

% Observations
x = [-0.2 2.6 1.3];

% Infinite
%mc = MarkovChain([0.75; 0.25], [0.99 0.01; 0.03 0.97]);
% Finite
mc = MarkovChain([1; 0], [0.9 0.1 0; 0 0.9 0.1]);
g1 = GaussD('Mean', 0, 'StDev', 1);
g2 = GaussD('Mean', 3, 'StDev', 2);

pX = prob([g1 g2], x);

disp('alphaHat and c from test sequence');
[alphaHat, c] = mc.forward(pX)
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       End of Testing of forward pass                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Testing of log prob                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open/close Testing of log prob here
%%{

% Observations
x = [-0.2 2.6 1.3];

% Infinite
%mc = MarkovChain([0.75; 0.25], [0.99 0.01; 0.03 0.97]);
% Finite
mc = MarkovChain([1; 0], [0.9 0.1 0; 0 0.9 0.1]);
g1 = GaussD('Mean', 0, 'StDev', 1);
g2 = GaussD('Mean', 3, 'StDev', 2);

h = HMM(mc, [g1 g2]);

disp('Log prob of test sequence');
logP = h.logprob(x)

%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      End of Testing of log prob                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%