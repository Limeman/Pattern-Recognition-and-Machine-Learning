function R=rand(pD,nData)
%R=rand(pD,nData) returns random scalars drawn from given Discrete Distribution.
%
%Input:
%pD=    DiscreteD object
%nData= scalar defining number of wanted random data elements
%
%Result:
%R= row vector with integer random data drawn from the DiscreteD object pD
%   (size(R)= [1, nData]
%
%----------------------------------------------------
%Code Authors:
%   Per Emil Hammarlund
%   Albert Öst
%----------------------------------------------------

if numel(pD)>1
    error('Method works only for a single DiscreteD object');
end;

% Create multinomial distribution to sample from
dist = makedist('Multinomial', 'Probabilities', pD.ProbMass);
% Generate the desired number of samples 
R = random(dist, 1, nData);
end