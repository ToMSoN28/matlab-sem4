% Dane
x = [0, 1, 2, 3];
y1 = [0, 1, 2, 3];
y2 = [3, 2, 1, 0];

% Wykresy
plot(x, y1, 'b-', x, y2, 'r-');
xlabel('x');
ylabel('y');
title('Wykresy y1 i y2');
legend('y1', 'y2');

% Znalezienie punktu przecięcia
[x_intersect, y_intersect] = intersect(x, y1, x, y2);
punkt_przeciecia = [x_intersect, y_intersect];

% Wyświetlenie punktu przecięcia
disp(['Punkt przecięcia: (', num2str(punkt_przeciecia), ')']);
