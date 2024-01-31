clc
clear
close all

condNumber = 200;   % wartość uwarunkowania
N = 4;  % rozmiar macierzy

% Metoda 1
Q = orth(rand(N));
S = diag(logspace(0, log10(condNumber), N));
P = orth(rand(N));
A = Q * S * P';

X = zeros(1,N);
Y = [1,2,3,4]

%A = [4 -1 -0.2 2; -1 5 0 -2; 0.2 1 10 -1; 0 -2 -1 4]
%Y = [30 0 -10 5]

%L = eye(N);
%U = A;


A %piewsza wartość wiersz, druga kolumna

[L,U]=luGauss(A);
L
U
Z = oblicz_z(L,Y);
X = oblicz_x(U,Z);

[L,U]=luCrouta(A);
L
U
Z = oblicz_z(L,Y);
X = oblicz_x(U,Z);

[L,U]=luDoolittle(A);
L
U
Z = oblicz_z(L,Y);
X = oblicz_x(U,Z);

disp(A*X');
disp(L*U-A);

function X = rozwLU(A,Y,metoda)
    switch metoda
        case "G"
            [L,U]=luGauss(A);
        case "C"
            [L,U]=luCrouta(A);
        case "D"
            [L,U]=luDoolittle(A);
    end

    Z = oblicz_z(L,Y);
    X = oblicz_x(U,Z);
end

function [L1, U1] = luCrouta(A)
    n = length(A);
    L = zeros(n,n);
    U = zeros(n,n);
    for i = 1 : n
        for k = i : n
            sum = 0;
            for j = 1 : i
                sum = sum + (L(k,j) * U(j,i));
            end
            L(k,i) = A(k,i) - sum;
        end

        for k = i : n
            if (i == k)
                U(i,i) = 1;
            else
                sum = 0;
                for j = 1 : i
                    sum = sum + (L(i,j) * U(j,k));
                end
                U(i,k) = (A(i,k) - sum)/L(i,i);
            end
        end
    end
    L1 = L;
    U1 = U;
end

function [L1, U1] = luDoolittle(A)
    n = length(A);
    L = zeros(n,n);
    U = zeros(n,n);
    for i = 1 : n
        for k = i :n
            sum = 0;
            for j = 1 : i
                sum = sum + (L(i,j) * U(j,k));
            end
            U(i,k) = A(i,k) - sum;
        end

        for k = i : n
            if (i == k)
                L(i,i) = 1;
            else
                sum = 0;
                for j = 1 : i
                    sum = sum + (L(k,j) * U(j,i));
                end
                L(k,i) = (A(k,i) - sum)/U(i,i);
            end
        end
    end
    L1 = L;
    U1 = U;
end

function [L, U] = luGauss(A)
    n = length(A);
    L = eye(n);
    U = A;
    for i = 1 : n
        [L, U] = eliminacionGauss(L,U,i);
    end
end


function [L1, U1] = eliminacionGauss (L,U,i)
    n = length(U);

    for j = i+1 : n
    tmp = U(j, i)/U(i, i);
    L(j,i) = tmp;
    elemV = tmp*U(i,:);
    U(j,:) = U(j,:)-elemV;  
    end
    
    L1 = L;
    U1 = U;
end

function Z1 = oblicz_z(L,Y)
    n = length(L);
    Z = zeros(1,n);
    for i = 1 : n
        Z(i) = oblicz_zi(L,Z,Y,i);
    end
    Z1 = Z;
end

function result = oblicz_zi (L,Z,Y,i)
    for j = 1 : i
        tmp = Z(1:i-1).*L(i,1:i-1);
        tmp = sum(tmp);
        tmp = Y(i) - tmp;
        tmp = tmp/L(i,i);
    end
    result = tmp;
end

function X1 = oblicz_x (U,Z)
    n = length(U);
    X = zeros(1,n);
    for i = n:-1:1
        X(i)=oblicz_xi(U,X,Z,i);
    end
    X1 = X;
end

function result = oblicz_xi (U, X, Z, i)
    n = length(U);
    for j = i-1 : n-1
        tmp = X(n-j:n).*U(i,n-j:n) ;
        tmp = sum(tmp);
        tmp = Z(i) - tmp;
        tmp = tmp/U(i,i);
    end
    result = tmp;
end
