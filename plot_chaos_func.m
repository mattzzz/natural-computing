% generate and plot chaosmap function
close all;

% initial params
iter_max = 300;
inital_chaos = 0.7;
cf = @chaos_f9;

% generate chaos map
chaosmap = zeros(iter_max);
c = cf(inital_chaos);
for i=1:iter_max
   c = cf(c);
   chaosmap(i) = c;
end

% plot chaos map
plot(chaosmap, 'r');
% axis([0 iter_max 0 1])
line([0 300], [0.5 0.5]);

title('Chaos map plot','fontsize',12)
xlabel('Iteration number i','fontsize',12);
ylabel('x_i_+_1','fontsize',12);