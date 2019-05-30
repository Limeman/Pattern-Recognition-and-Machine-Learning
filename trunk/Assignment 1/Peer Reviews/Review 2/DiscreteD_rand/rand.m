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
%----------------------------------------------------

% we need to generate a vector(1*ndata) in accordance with pD.
if numel(pD)>1
    error('Method works only for a single DiscreteD object');
else
    len=length(pD.ProbMass);
    %R=zeros(1,len); %need to be modified
    R=zeros(1,nData);
    %x=rand(1,len);
    x=rand(1,nData);
    Threshold=zeros(1,len);
    for i=1:len
        Threshold(i)=sum(pD.ProbMass(1:i));
    end
    for i=1:nData
        T=find(x(i)<Threshold);
        R(i)=T(1);
        clear T
    end
    %for i=1:len
    %    if i==1
    %       R(find(x<pD.ProbMass(i)))=i;
    %    else
    %        s=sum(pD.ProbMass(1:(i-1)));
    %        R(find(x>s))=i;
    %    end
    %end
    
end
%*** Insert your own code here and remove the following error message 

%error('Not yet implemented');
