% Usage example for boundary_locus
% related to Exercise 6.8

rho = [1; 0; -1];
sigma = [0; 2; 0];
n = 100;
[ z ] = boundary_locus( rho,sigma,n );
% plot z on the complex plane
f=figure;
x=real(z);
y=imag(z);
plot(x,y);
title('Explicit midpoint rule');
axis([-1.5 1.5 -1.5 1.5]);
xlabel('Re');
ylabel('Im');
grid on;
