a = 0;
b = 1;
n = 5;

fun = @(x) x^2;

p = wBo(a,b,n,fun)

function p = wTr (a, b, n, fun)
    p = 0;
    tmp = linspace(a,b,n);
    for i = 1 : n-1
        p = p + ((fun(tmp(i))+fun(tmp(i+1)))/2)*((b-a)/(n-1));
    end
end

function p = wSi13 (a, b, n, fun)
    tmp = linspace(a,b,n);
    p = 0;
    for i=1:n-1
        tmp1 = linspace(tmp(i),tmp(i+1),3);
        h = (tmp(i+1)-tmp(i))/2;
        p =p + (fun(tmp1(1)) + 4*fun(tmp1(2)) + fun(tmp1(3)))*h/3;
    end
    
end

function p = wSi38 (a, b, n, fun)
    tmp = linspace(a,b,n);
    p = 0;
    for i=1:n-1
        tmp1 = linspace(tmp(i),tmp(i+1),4);
        h = (tmp(i+1)-tmp(i))/3;
        p = p + (fun(tmp1(1)) + 3*fun(tmp1(2)) + 3*fun(tmp1(3)) +fun(tmp1(4)))*3*h/8;
    end
end

function p = wBo (a, b, n, fun)
    tmp = linspace(a,b,n);
    p = 0;
    for i=1:n-1
        tmp1 = linspace(tmp(i),tmp(i+1),5);
        h = (tmp(i+1)-tmp(i))/4;
        p =p + (7*fun(tmp1(1)) + 32*fun(tmp1(2)) + 12*fun(tmp1(3)) + 32*fun(tmp1(4)) + 7*fun(tmp1(5)))*2*h/45;
    end
end


