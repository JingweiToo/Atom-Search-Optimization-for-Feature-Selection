# Atom Search Optimization for Feature Selection

[![View Atom Search Optimization for Feature Selection on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78540-atom-search-optimization-for-feature-selection)
[![License](https://img.shields.io/badge/license-BSD_3-yellow.svg)](https://github.com/JingweiToo/Atom-Search-Optimization-for-Feature-Selection/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/badge/release-1.3-green.svg)](https://github.com/JingweiToo/Atom-Search-Optimization-for-Feature-Selectionx)

![Wheel](https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/2f88f03f-4813-4247-9322-275df5cead77/028b33c2-ea8c-4fd7-9520-7277eac17a41/images/1595500066.JPG)


## Introduction
* This toolbox offers an Atom Search Optimization ( ASO ) method  
* The `Main` illustrates the example of how ASO can solve the feature selection problem using benchmark data-set. 


## Input
* *`feat`*     : feature vector ( Instances *x* Features )
* *`label`*    : label vector ( Instances *x* 1 )
* *`N`*        : number of atoms
* *`max_Iter`* : maximum number of iterations
* *`alpha`*    : depth weight
* *`beta`*     : multiplier weight


## Output
* *`sFeat`*    : selected features
* *`Sf`*       : selected feature index
* *`Nf`*       : number of selected features
* *`curve`*    : convergence curve


### Example
```code
% Benchmark data set 
load ionosphere.mat;  

% Set 20% data as validation set
ho = 0.2; 
% Hold-out method
HO = cvpartition(label,'HoldOut',ho);

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
```


## Requirement
* MATLAB 2014 or above
* Statistics and Machine Learning Toolbox


## Cite As
```code
@article{too2020chaotic,
  title={Chaotic Atom Search Optimization for Feature Selection},
  author={Too, Jingwei and Abdullah, Abdul Rahim},
  journal={Arabian Journal for Science and Engineering},
  pages={1--17},
  year={2020},
  publisher={Springer}
}
```

