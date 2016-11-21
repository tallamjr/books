% Usage example for boundary_locus
% related to the Adams-Bashforth methods

n=100;
rho = [1; -1];
sigma = [0; 1];
[ z ] = boundary_locus( rho,sigma,n );
plot(z);
title('Adams-Bashforth methods');
hold on;
rho = [1; -1; 0];
sigma = [0; 3/2; -1/2];
[ z ] = boundary_locus( rho,sigma,n );
plot(z);
rho = [1; -1; 0; 0];
sigma = [0; 23/12; -4/3; 5/12];
[ z ] = boundary_locus( rho,sigma,n );
plot(z);
axis([-5/2 1/2 -3/2 3/2]);
grid on;