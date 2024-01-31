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

A = [4 -1 -0.2 2; -1 5 0 -2; 0.2 1 10 -1; 0 -2 -1 4]
Y = [30 0 -10 5]


A %piewsza wartość wiersz, druga kolumna

for i = 1 : N
    A = eliminacion(A,i);
end

for i = N:-1:1
    X(i)=oblicz_xi(A,X,Y,i);
end

A
Y
X

b=A*X';
b=Y'- b;
b = b.^2;
err = sqrt(sum(b))

%err = norm(Y'-A*X')

function result = eliminacion (A,i)
    n = length(A);

    for j = i+1 : n
    tmp = A(j, i)/A(i, i);
    elemV = tmp*A(i,:);
    A(j,:) = A(j,:)-elemV;  
    end

    result = A;
end



function result = oblicz_xi (A, X, Y, i)
    n = length(A);
    for j = i-1 : n-1
        tmp = X(n-j:n).*A(i,n-j:n) ;
        tmp = sum(tmp);
        tmp = Y(i) - tmp;
        tmp = tmp/A(i,i);
    end
    result = tmp;
end

