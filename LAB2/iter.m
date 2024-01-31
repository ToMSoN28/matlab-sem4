clc
clear
close all

condNumber = 200;   % wartość uwarunkowania
N = 40;  % rozmiar macierzy

% Metoda 1
% Q = rand(N);
% D = diag(linspace(0.1, 0.7, N));
% A = Q * D / Q;

A = rand(N);
D = diag(sum(abs(A), 2));
A = A + D;

eig(A)

%A = [4 -1 -0.2 2; -1 5 0 -2; 0.2 1 10 -1; 0 -2 -1 4]
%Y = [30 0 -10 5]
Y = linspace(1, N, N);

A %piewsza wartość wiersz, druga kolumna

%[L,D,U] = ldu(A)
%[M,W] = GaSe(A,Y)
%[M,W] = SOR(A,Y)
[M,W] = jacobi (A,Y);
%M
%W

%d=eig(M); %wektor wartości własnych
%max(abs(d)) %musi być miniejsze od 1

X = iteration(A,Y,"S");

function X = iteration (A,Y,metoda)
    n= length(A);
    err = inf;
    switch metoda
        case "J"
            [M,W] = jacobi (A,Y);
        case "G"
            [M,W] = GaSe(A,Y);
        case "S"
            [M,W] = SOR(A,Y);
    end
    X = zeros(1,n);
    %inicjalizacja x
    for i = 1 : length(A)
        X(i) = 1;
    end
    %A = inv(M) * A
    %Y = (inv(M) * Y')'
    
    i=0;
    while err > 10^(-12)
        [X, err] = obliczIter(A,X,Y,M,W);
        i = i+1;   
    end
    err
    i;
end

function [X1, err1] = obliczIter (A,X,Y,M,W)
    Xn = (M * X')' + W;
    b = (Y' - (A * Xn')).^2;
    x = X.^2;
    xe = sqrt(sum(x));
    be = sqrt(sum(b));
    err1 = be/xe;
    X1 = Xn;
end

function [M,W] = jacobi (A,Y)
    n = length(A);
    D = zeros(n,n);
    M = zeros(n,n);
    W = zeros(1,n);
    for i = 1 : n
        D(i,i) = A(i,i);
    end
    M = -(A - D); % -(L+U)
    D = inv(D);
    M = D * M;
    for i = 1 : n
        W(i) = Y(i) * D(i,i);
    end
end

function [M,W] = GaSe (A,Y)
    n = length(A);
    M = zeros(n,n);
    W = zeros(1,n);
    [L,D,U] = ldu(A);
    M = -inv(D+L) * U;
    W = (inv(D+L) * Y')'; 
end

function [M,W] = SOR (A,Y)
    n = length(A);
    omg = 1.1;
    M = zeros(n,n);
    W = zeros(1,n);
    [L,D,U] = ldu(A);
    M = (D+omg*L)\((1-omg)*D-omg*U)
    W = ((D+omg*L)\(omg*Y'))'
end

function [L,D,U] = ldu(A)
    n = length(A);
    L = zeros(n,n);
    D = zeros(n,n);
    U = zeros(n,n);

    for i = 1 :n
        for j = 1 :n
            if (i == j)
                D(i,i) = A(i,i);
            elseif (i<j)
                U(i,j) = A(i,j);
            elseif (i>j)
                L(i,j) = A(i,j);
            end

        end
    end

end
