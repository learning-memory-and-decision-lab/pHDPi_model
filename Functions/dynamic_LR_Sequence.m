
function[postCPtrialLR, postSEQRtrialLR] = dynamic_LR_Sequence(outcome,prediction,mu)


if (size(outcome,2)~=1)
    outcome = outcome';
end


newBlock=false(size(outcome));
newBlock(1)=true;


if (size(prediction,2)~=1)
    prediction = prediction';
end


[~, UP, PE]=computeLR(outcome,prediction, newBlock);

% Compute Learning Rate for one simulation: "UP = Updates" as a funtion of
% "PE = Prediction Errors"

mean_PE=nan(length(outcome),1);   %nans 
mean_PE(1:end-1) = (mu(2:end) - prediction(1:end-1));
xes=[ones(size(PE)),PE,mean_PE];


C2 = regress(UP,xes);
postCPtrialLR=C2(2);
postSEQRtrialLR=C2(3);


