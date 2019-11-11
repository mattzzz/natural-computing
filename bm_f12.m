% benchmark function 12 - Rastrigin
function y = bm_f12(X)
    y = sum(X.^2 - 10*cos(2*pi*X)+10, 2);
end