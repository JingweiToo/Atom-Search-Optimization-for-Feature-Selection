function [sFeat,Sf,Nf,curve] = jASO(feat,label,N,max_Iter,alpha,...
  beta,HO)

lb  = 0;
ub  = 1; 

fun = @jFitnessFunction; 
dim = size(feat,2); 
X   = zeros(N,dim);
V   = zeros(N,dim); 
for i = 1:N
	for d = 1:dim
    X(i,d) = lb + (ub - lb) * rand(); 
    V(i,d) = lb + (ub - lb) * rand();
  end
end
A    = zeros(N,dim);
fitG = inf; 
fit  = zeros(1,N); 

curve = inf;
t = 1;
%---Iteration start--------------------------------------------------
while t <= max_Iter
  for i = 1:N
    fit(i) = fun(feat,label,(X(i,:) > 0.5),HO);
    if fit(i) < fitG
      fitG = fit(i); 
      Xgb  = X(i,:);
    end
  end
  fitB  = min(fit);
  fitW  = max(fit); 
  Kbest = ceil(N - (N - 2) * sqrt(t / max_Iter));   
  M     = exp(-(fit - fitB) ./ (fitW - fitB));
  M     = M ./ sum(M);
  [~, idx_M] = sort(M,'descend');
  G     = exp(-20 * t / max_Iter); 
  E     = zeros(N,dim); 
  for i = 1:N      
     XK(1,:)    = sum(X(idx_M(1:Kbest), :), 1) / Kbest;
     scale_dist = norm(X(i,:) - XK(1,:), 2);   
    for ii = 1:Kbest
      j    = idx_M(ii);
      Po   = jLJPotential(X(i,:),X(j,:),t,max_Iter,scale_dist);
      dist = norm(X(i,:) - X(j,:), 2);
      for d = 1:dim
        E(i,d) = E(i,d) + rand() * Po * ((X(j,d) - X(i,d)) / ...
          (dist + eps));
      end
    end
    for d = 1:dim
      E(i,d) = alpha * E(i,d) + beta * (Xgb(d) - X(i,d));
      A(i,d) = E(i,d) / M(i);
    end
  end
  for i = 1:N
    for d = 1:dim
      Acce   = A(i,d) * G;
      V(i,d) = rand() * V(i,d) + Acce;
      X(i,d) = X(i,d) + V(i,d);
    end
    XB = X(i,:);  XB(XB > ub) = ub;  XB(XB < lb) = lb;
    X(i,:) = XB;
  end
  curve(t) = fitG; 
  fprintf('\nIteration %d Best (ASO)= %f',t,curve(t))
  t = t + 1;
end
Pos   = 1:dim;
Sf    = Pos((Xgb > 0.5) == 1); 
Nf    = length(Sf); 
sFeat = feat(:,Sf); 
end


function Potential = jLJPotential(X1,X2,t,max_Iter,dim)
h0   = 1.1; 
u    = 1.24; 
r    = norm(X1 - X2, 2);
n    = (1 - (t - 1) / max_Iter) .^ 3;
g    = 0.1 * sin((pi / 2) * (t / max_Iter));
Hmin = h0 + g;
Hmax = u;
if r / dim < Hmin
  H = Hmin;
elseif r / dim > Hmax
  H = Hmax;  
else
  H = r / dim;
end           
Potential = n * (12 * (-H) ^ (-13) - 6 * (-H) ^ (-7)); 
end


