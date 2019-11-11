% chaos map 2 - Circle
function y = chaos_f2(x)
    a = 0.5;
    b = 0.2;
    y = mod(x+b-(a/(2*pi))*sin(2*pi*x),1);
end