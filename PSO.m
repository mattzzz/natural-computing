% PSO - standard Particle Swarm Optimisation algorithm

clear;

% initialise parameters
lower_bound = -5.12;
upper_bound = 5.12;
PS          = 30;       % population size
m           = 30;       % dimensions
w           = 0.6;
alpha1      = 2;
alpha2      = 2;
iter_max    = 10000;
f           = @bm_f12;   % benchmark function

% initialise particles
X = lower_bound + (upper_bound - lower_bound) * rand(PS, m);

% initialise global and particle bests
g_hat = ones(1, m)*10000;
x_hat = ones(PS, m)*10000;

% initialise velocity
V = ones(PS, m)*(upper_bound - lower_bound)*.1;

% iterate each generation
for iter=1:iter_max
    % for each particle in the population..
    for i=1:PS
        % generate two random vectors
        r1 = rand(1, m);
        r2 = rand(1, m);

        % calculate velocity for each particle
        V(i,:) = w*V(i,:) + alpha1*r1 .* (x_hat(i,:) - X(i,:)) + alpha2 * r2 .* (g_hat - X(i,:));
        
        % update the particle's location
        X(i,:) = X(i,:) + V(i,:);
        
        % calculate fitness of the particle
        fi = f(X(i,:));
        
        % update the particle and global bests
        if fi < f(x_hat(i,:))
            x_hat(i,:) = X(i,:);
        end
        if fi < f(g_hat)
            g_hat = X(i,:);
        end
    end
    
    [iter f(g_hat)]
    
    % early termination
    if f(g_hat) < -0.00001
%         break
    end
    
    yy(iter) = f(g_hat);
end

f(g_hat)

plot(yy)
title('PSO optimization process','fontsize',12)
xlabel('Iteration Number','fontsize',12);
ylabel('Fitness','fontsize',12);
