% CFOA - Chaotic Fruit Fly Optimisation Algorithm
%
% this version is based on the exact pseudocode presented in the original
% paper
%

clear;
close all;

% initialise parameters
PS          = 30;           % population size
lower_bound = -5.12;
upper_bound = 5.12;
n           = 30;           % dimensions
iter_max    = 10000;
init_chaos  = 0.95;
f           = @bm_f12;       % benchmark function 
cmf         = @chaos_f9;    % chaos map function

% generate chaos map
chaosmap = zeros(iter_max, 1);
c = cmf(init_chaos);
for i=1:iter_max
   chaosmap(i) = c;
   c = cmf(c);
end

% generate initial fruit fly population
X = zeros(PS, n);
for i=1:PS
    for j=1:n
        X(i,j) = lower_bound + (upper_bound - lower_bound) * rand();
    end
end

% set the initial global best
[v, idx] = min(f(X));
delta = X(idx,:);
X_star = delta;

% iterate through moving fruit flies towards food (global best)
for iter=1 : iter_max
    
    % update fruit flies by smelling towards food
    for i=1:PS
        
        alpha = chaosmap(iter);
        
        for j=1:n
            diff = (X(i,j) - X_star(j));
            X(i,j) = X(i,j) + alpha * diff;

            if X(i,j) > upper_bound 
                X(i,j) = upper_bound;
            end
            if X(i, j) < lower_bound
                X(i,j) = lower_bound;
            end
        end
    end
    
    % vision test towards best
    [v, idx] = min(f(X));
    
    % get the best from current population
    X_best = X(idx,:);
    [iter f(X_star)]
    
    if f(X_best) < f(delta)
        delta = X_best;
    end
    
    % update global best if new best is found
    if f(delta) < f(X_star)
        X_star = delta;
    end

    % early terminate of close enough to global min
    if f(X_star) < 0.0001
%         break
    end
end

f(X_star)
