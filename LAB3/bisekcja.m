fun = @(x) x - 1.111111;
a = 1;
b = 2;
eps = 10^(-5);

[x,i] = bisek2(a,b,fun,eps)



function [x,i] = bisek2(a, b, fun, eps)
    i=0
    x=0
    while(abs(a-b) > eps)

        x = (a + b) / 2;
        if fun(x) * fun(a) < 0
            b = x;
        else
            a = x;
        end
        i=i+1;
    end
    i;
end

function x = bisekZP(a, b, fun, eps)
    i=0
    while(abs(a-b) > eps)

        x = zlatyPodzial(a,b)
        if fun(x) * fun(a) < 0
            b = x;
        else
            a = x;
        end
        i=i+1
    end
end

function x = zlatyPodzial(a,b)
    rho = (sqrt(5) + 1)/2;
    x = (b-a)/rho;
    x=x+a;
end
