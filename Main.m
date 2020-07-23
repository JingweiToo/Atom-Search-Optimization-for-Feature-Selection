%-------------------------------------------------------------------------%
%  Atom Search Optimization (ASO) source codes demo version               %
%                                                                         %
%  Programmer: Jingwei Too                                                %
%                                                                         %
%  E-Mail: jamesjames868@gmail.com                                        %
%-------------------------------------------------------------------------%


%---Inputs-----------------------------------------------------------------
% feat:   features
% label:  labelling
% N:      Number of particles
% T:      Maximum number of iterations
% alpha:  Depth weight
% beta:   Multiplier weight
% *Note: k-value of KNN & hold-out setting can be modified in jFitnessFunction.m
%---Outputs----------------------------------------------------------------
% sFeat:  Selected features
% Sf:     Selected feature index
% Nf:     Number of selected features
% curve:  Convergence curve
%--------------------------------------------------------------------------



%% Atom Search Optimization
clc, clear, close; 
% Benchmark data set 
load ionosphere.mat; 
% Parameter setting
N=10; T=100; alpha=50; beta=0.2;
% Atom Search Optimization
[sFeat,Sf,Nf,curve]=jASO(feat,label,N,T,alpha,beta);
% Plot convergence curve
figure(); plot(1:T,curve); xlabel('Number of iterations');
ylabel('Fitness Value'); title('ASO'); grid on;



