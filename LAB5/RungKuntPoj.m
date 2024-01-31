% Punkt początkowy
x0 = 0; 
y0 = 1;
% Punkt końcowy
xn = 1;
% Ustawienie kroku h
h = 0.1; 
% Rząd metody
r = 4;

f = @(x,y) x^2 + y;
g = @(x,y) x^3 - y;

y1 = RKP ( x0, y0, xn, h, g, r);
y1
ABP ( x0, y0, xn, h, g, r)

function y = ABP ( x0, y0, xn, h, fun, r)
    x = x0;
    switch r
        case 1
            y = y0;
            while x(end) < xn
                tmp1 = y(end) + h*fun(x(end),y(end));
                y = [y,tmp1];
                x = [x, x(end)+h];
            end

        case 2
            y = RKP (x0,y0,x+h,h,fun,r);
            x = [x, x(end)+h];
            while x(end) < xn
                tmp2 = y(end) + h*(3*fun(x(end),y(end))-fun(x(end-1),y(end-1)))/2;
                y = [y,tmp2];
                x = [x, x(end)+h];
            end

        case 3
            y = RKP (x0,y0,x+2*h,h,fun,r);
            x = [x, x(end)+h];
            x = [x, x(end)+h];
            while x(end) < xn
                tmp3 = y1(end) + h*(23*fun(x(end),y(end))-16*fun(x(end-1),y(end-1))+5*fun(x(end-2),y(end-2)))/12;
                y = [y,tmp3];
                x = [x, x(end)+h];
            end

        case 4
            y = RKP (x0,y0,x+3*h,h,fun,r);
            x = [x, x(end)+h];
            x = [x, x(end)+h];
            x = [x, x(end)+h];
            while x(end) < xn
                tmp1 = y(end) + h*(55*fun(x(end),y(end))-59*fun(x(end-1),y(end-1))+37*fun(x(end-2),y(end-2))-9*fun(x(end-3),y(end-3)))/24;
                y = [y,tmp1];
                x = [x, x(end)+h];
            end
    end

end



function y = RKP ( x0, y0, xn, h, fun, r)
    x = x0;
    y1 = y0;
    y2 = y0;
    y3 = y0;
    y4 = y0;

    while x(end) < xn
        % Obliczanie wartości K1, K2, K3, K4
        k11 = h*fun(x(end),y1(end));
        k12 = h*fun(x(end),y2(end));
        k13 = h*fun(x(end),y3(end));
        k14 = h*fun(x(end),y4(end));
        k22 = h*fun(x(end) + k12, y2(end) + h);
        k23 = h*fun(x(end) + k13/2, y3(end) + h/2);
        k24 = h*fun(x(end) + k14/2, y4(end) + h/2);
        k33 = h*fun(x(end) + 2*k23 - k13, y3(end) + h);
        k34 = h*fun(x(end) + k24/2, y4(end) + h/2);
        k44 = h*fun(x(end) + k34, y4(end) + h);
    
        % Obliczanie wartości y dla kolejnego kroku
        tmp1 = y1(end) + k11;
        tmp2 = y2(end) + (k12 + k22)/2;
        tmp3 = y3(end) + (k13 + 4*k23 + k33)/6;
        tmp4 = y4(end) + (k14 + 2*k24 + 2*k34 + k44)/6;

        y1 = [ y1, tmp1];
        y2 = [ y2, tmp2];
        y3 = [ y3, tmp3];
        y4 = [ y4, tmp4];
    
        % Przesuń się do kolejnej wartości x
        tmp = x(end) + h;
        x = [x,tmp];
    end
    switch r
        case 1
            y = y1;
        case 2
            y = y2;
        case 3
            y = y3;
        case 4
            y = y4;
    end
end


