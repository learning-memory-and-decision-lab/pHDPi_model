
function[postCPtrial_PE,postCPtrial_Mu_PE] = dynamic_LR_reversal(outcome,prediction,mu,cp)



if (size(outcome,2)~=1)
    outcome = outcome';
end


newBlock=false(size(outcome));
newBlock(1)=true;

if (size(prediction,2)~=1)
    prediction = prediction';
end

[~, UP, PE]=computeLR(outcome,prediction,newBlock);
mean_PE = (mu - prediction);
for ct = 1:length(cp)
    if cp(ct) == 1 || ct ==1
        TAC(ct) = 0;
    else
        TAC(ct) = TAC(ct-1) + 1;
    end
end
% Compute Learning Rate for one simulation: "UP = Updates" as a funtion of
% "PE = Prediction Errors"
xes=[ones(size(PE)),PE,mean_PE.*cp];

% 
% for t=1:7
%     prob = TAC==t-1;
    C2 = regress(UP,xes);
    postCPtrial_PE=C2(2);
    postCPtrial_Mu_PE=C2(3);
% end
