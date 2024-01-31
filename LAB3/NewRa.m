fun = @(x) sin(x);
funP = @(x) cos(x);
a = 3;
b = 4;
eps = 10^(-5);

x = NewtonRaphson( a, b, 3.3, fun, funP, eps)

function x = NewtonRaphson (a, b, x, fun, funP, eps)
    %x = (a+b)/2;
    if x == 1
        r = 2;
    else
        r = 1;
    end
    i = 0;
    while(abs(r-x)>eps)
        r = x;
        x = x - (fun(x)/funP(x));
        i = i + 1;
    end
    i;
end

function x = NewtonRaphsonOblP (a, b, x, fun, funP, eps, h)
    %x = (a+b)/2;
    if x == 1
        r = 2;
    else
        r = 1;
    end
    i = 0;
    while(abs(r-x)>eps)
        r = x;
        x = x - (fun(x)/pochodnaWPkt(x, fun, h));
        i = i + 1;
    end
    i
end

function fx = pochodnaWPkt (x, fun, h)
    fx  = (fun(x+h) - fun(x))/h;
end