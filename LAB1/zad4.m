clc
clear
close all


xd = -1;
xu = 1;
len = 15;



xi = linspace (xd,xu,1000);
yi = 1./(1+(xi.^10));


x = linspace(xd,xu,len);
y = 1./(1+x.^10);
p = zeros(1,len);
%interpolacja wielomanem Lagranga
for i = 1 : len
    tmp1=x;
    tmp1(i) = [];
    tmp2=poly(tmp1);
    tmp1=x(i)-tmp1;
    tmp2=tmp2*y(i)/prod(tmp1);
    p=p+tmp2;
end

b = zeros(2,1000);
yo=polyval(p,xi);


for a = 1 : 1000
    b(1,a) = abs(yi(a)-yo(a));
    b(2,a) = b(1,a)/yi(a);
end

figure;
plot(xi,b);
%błąd bezwzględny niebieski
%błąd względny pomarańczowy

figure;
plot(x,y,'ob'); hold on;
plot(xi,yi);
plot(xi,yo);

mean(b(1,:))
max(b(1,:))
mean(b(2,:))
max(b(2,:))
