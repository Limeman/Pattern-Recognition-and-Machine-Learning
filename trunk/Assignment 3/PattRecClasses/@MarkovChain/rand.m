function S=rand(mc,T)
%S=rand(mc,T) returns a random state sequence from given MarkovChain object.
%
%Input:
%mc=    a single MarkovChain object
%T= scalar defining maximum length of desired state sequence.
%   An infinite-duration MarkovChain always generates sequence of length=T
%   A finite-duration MarkovChain may return shorter sequence,
%   if END state was reached before T samples.
%
%Result:
%S= integer row vector with random state sequence,
%   NOT INCLUDING the END state,
%   even if encountered within T samples
%If mc has INFINITE duration,
%   length(S) == T
%If mc has FINITE duration,
%   length(S) <= T
%
%---------------------------------------------
%Code Authors:
% Per Emil Hammarlund
% Albert Öst
%---------------------------------------------

S=zeros(1,T);%space for resulting row vector
nS=mc.nStates;

% Construct randomizers
initial_prob = DiscreteD(mc.InitialProb);
transition_prob = DiscreteD(mc.TransitionProb);

% Check if chains duration is finite or not
fd = finiteDuration(mc);

% Randomize the initial state
S(1) = initial_prob.rand(1);
end_state = -1;
for i=2:T
    
    % Randomize the next state based on the previous state
    S(i) = transition_prob(S(i - 1)).rand(1);
    
    %   If the markov chain is finite and the end state S(T+1)=(nStates+1)
    % is reached, then break the loop
    if fd && S(i) == nS + 1
       end_state = i;
       break 
    end
end
if end_state ~= -1
   S = S(1:end_state - 1);
end
end