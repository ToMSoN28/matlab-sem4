clc
clear
close all


xd = -1;
xu = 1;
len = 30;



xi = linspace (xd,xu,1000);
yi = 1./(1+(xi.^10));


x = linspace(xd,xu,len);
y = 1./(1+x.^10);
f = zeros(len,len);


f(:,1) = y;
for j = 2 : len
    for i = j : len
        f(i,j) = (f(i,j-1)-f(i-1,j-1))/(x(i)-x(i-j+1));
    end
end

p = zeros(1,len);

p(1) = y(1);

for j = 2 : len
    for a = 1 : j-1
        tmp(a)=x(a);
    end
    tmp = poly(tmp);
    tmp = flip(tmp);
    tmp = tmp * f(j,j);
    for a = 1 : j
        p(a) = p(a) + tmp(a);
    end

end

p = flip(p);

xo = linspace (xd,xu,1000);
yo=polyval(p,xo);

figure;
plot(x,y,'ob'); hold on;
plot(xi,yi);
plot(xo,yo);


    
