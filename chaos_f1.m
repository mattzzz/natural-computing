% chaos map 1 - Chebyshev
function y = chaos_f1(x)
    persistent i;
    if isempty(i)
        i = 0;
    end
    i=i+1;
    y = cos(i*acos(x));
end