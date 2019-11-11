% CFOA - Chaotic Fruit Fly Optimisation Algorithm
%
% this version has been adapted to include fixes and improvements 
% as detailed in the report
%

clear;

% initialise parameters
PS          = 30;
lower_bound = -100;
upper_bound = 100;
n           = 30;           % dimensions
iter_max    = 100000;
init_chaos  = 0.95;
f           = @bm_f1;      % benchmark function 
cmf         = @chaos_f1;    % chaos map function

% generate chaos map
chaosmap = zeros(iter_max, 1);
c = cmf(init_chaos);
for i=1:iter_max
   chaosmap(i) = c;
   c = cmf(c);
end

% generate initial fruit fly population
X = lower_bound + (upper_bound - lower_bound) * rand(PS, n);

% set the initial global best
[v, idx] = min(f(X));
X_star = X(idx,:);

% iterate through moving fruit flies towards food (global best)
for iter=1 : iter_max
    
    % update fruit flies by smelling towards food
    for i=1:PS

        % get a chaotic parameter
        alpha = chaosmap(iter);
        
        for j=1:n
%             X(i,j) = X(i,j) + rand()*2-1;
%             X(i,j) = X_star(j) + rand()*2-1;

            diff = (X(i,j) - X_star(j));
            if diff < 0.000000001
                % if fly is at best move it randomly away
                X(i,j) = X_star(j) + rand()*2-1;
            else
                % move fly chaotically towards best
                X(i,j) = X(i,j) - alpha * diff;
            end
            
            % clamp the flies within the boundaries
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
    
    % update global best if new best is found
    if f(X_best) < f(X_star)
        X_star = X_best;
%         X = lower_bound + (upper_bound - lower_bound) * rand(PS, n);
    end

    % early terminate of close enough to global min
    if f(X_star) < 0.0001
%         break
    end
    
    [iter f(X_star)]
    yy(iter) = f(X_star);
end

f(X_star)

plot(yy)
title('CFOA optimization process','fontsize',12)
xlabel('Iteration Number','fontsize',12);
ylabel('Fitness','fontsize',12);
