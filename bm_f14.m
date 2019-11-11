% benchmark function F14 - Solomon problem
function y = bm_f14(X)
    T = X;
    y = 1 - cos(2*pi*sqrt(sum(T.^2)))+0.1*sqrt(sum(T.^2));
end