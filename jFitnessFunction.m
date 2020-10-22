% Notation: This fitness function is for demonstration 

function cost=jFitnessFunction(feat,label,X,HO)
alpha=0.99; beta=0.01;
maxFeat=length(X); 
if sum(X==1)==0
  cost=1;
else
  Error=jwrapperKNN(feat(:,X==1),label,HO);
  Nsf=sum(X==1);
  cost=alpha*Error+beta*(Nsf/maxFeat); 
end
end


function ER=jwrapperKNN(sFeat,label,HO)
%---// Parameter setting for k-value of KNN //
k=5; 
xtrain=sFeat(HO.training==1,:); ytrain=label(HO.training==1); 
xvalid=sFeat(HO.test==1,:); yvalid=label(HO.test==1); 
Model=fitcknn(xtrain,ytrain,'NumNeighbors',k); 
pred=predict(Model,xvalid); 
N=length(yvalid); correct=0;
for i=1:N
  if isequal(yvalid(i),pred(i))
    correct=correct+1;
  end
end
Acc=correct/N; 
ER=1-Acc;
end
