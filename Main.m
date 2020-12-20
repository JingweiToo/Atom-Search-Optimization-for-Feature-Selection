%-------------------------------------------------------------------%
%  Atom Search Optimization (ASO) demo version                      %
%-------------------------------------------------------------------%


%---Inputs-----------------------------------------------------------
% feat     : feature vector (instances x features)
% label    : label vector (instances x 1)
% N        : Number of atoms
% max_Iter : Maximum number of iterations
% alpha    : Depth weight
% beta     : Multiplier weight

%---Outputs----------------------------------------------------------
% sFeat    : Selected features
% Sf       : Selected feature index
% Nf       : Number of selected features
% curve    : Convergence curve
%--------------------------------------------------------------------


%% Atom Search Optimization
clc, clear, close; 
% Benchmark data set 
load ionosphere.mat;  

% Set 20% data as validation set
ho = 0.2; 
% Hold-out method
HO = cvpartition(label,'HoldOut',ho,'Stratify',false);

% Parameter setting
N        = 10; 
max_Iter = 100; 
alpha    = 50; 
beta     = 0.2;
% Atom Search Optimization
[sFeat,Sf,Nf,curve] = jASO(feat,label,N,max_Iter,alpha,beta,HO);

% Plot convergence curve
plot(1:max_Iter,curve);
xlabel('Number of iterations');
ylabel('Fitness Value');
title('ASO'); grid on;


