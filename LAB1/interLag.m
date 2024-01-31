clc
clear
close all


xd = 1,5;
xu = 21.5;
len = 10;



xi = linspace (xd,xu,1000);
yi = log(xi).*sin(xi);


x = linspace(xd,xu,len);
y = log(x).*sin(x);
p = zeros(1,len);

for i = 1 : len
    tmp1=x;
    tmp1(i) = [];
    tmp2=poly(tmp1);
    tmp1=x(i)-tmp1;
    tmp2=tmp2*y(i)/prod(tmp1);
    p=p+tmp2;
end

%xo = linspace (xd,xu,1000);
yo=polyval(p,xi)

figure;
plot(x,y,'ob'); hold on;
plot(xi,yi);
plot(xi,yo);

