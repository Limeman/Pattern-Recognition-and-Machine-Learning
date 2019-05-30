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
%---------------------------------------------

S=zeros(1,T);%space for resulting row vector
nS=mc.nStates;% the number of states

%set general values
pIteration=(mc.InitialProb)';%convenient for later step
p0=DiscreteD(pIteration);
pTran=mc.TransitionProb;
len=size(pTran,2);

%set initial state
%InitialValue=p0.rand(nS);
S(1)=p0.rand(1);% If the row <> state number, then it's a finite state.

if len==nS %infinite duration
%set transtion state
    for i=2:T
        for j=1:nS
        pIteration=pTran(S(i-1),:); %re-calculate possibility distribution after each loop
        end
        p1=DiscreteD(pIteration);
        S(i)=p1.rand(1);%generate new state sequence according to new distribution 
        %S(i)=TransValue(1);
    end
    
else %finte duration
  %set transtion state      
    for i=2:T         
        for j=1:len
        pIteration=pTran(S(i-1),:);
        end
        p1=DiscreteD(pIteration);
        TransValue=p1.rand(nS+1);
        if TransValue(1)==nS+1
            break;
        else
             S(i)=TransValue(1);
        end
        pIteration=pIteration(1:nS);
    end
    S(S==0)=[]; %remove zeros at the tail of state sequence vector 
end
end                

