%benchmark function F7 - Rosenbrock
function y = bm_f7(X)
    y = zeros(size(X,1),1);
    for i=1:size(X,1)
        for j=1:size(X,2)-1
            y(i) = y(i) + (100*(X(i,j+1)-X(i,j).^2).^2+(X(i,j)-1).^2);
        end
    end
end