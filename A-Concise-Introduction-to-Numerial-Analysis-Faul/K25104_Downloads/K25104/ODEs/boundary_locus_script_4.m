% Usage example for boundary_locus
% related to the Adams-Moulton methods

n=100;
rho = [1; -1];
sigma = [1/2; 1/2];
[ z ] = boundary_locus( rho,sigma,n );
plot(z);
title('Adams-Moulton methods');
hold on;
rho = [1; -1; 0];
sigma = [5/12; 2/3; -1/12];
[ z ] = boundary_locus( rho,sigma,n );
plot(z);
rho = [1; -1; 0; 0];
sigma = [3/8; 19/24; -5/24; 1/24];
[ z ] = boundary_locus( rho,sigma,n );
plot(z);
axis([-6.5 1/2 -4 4]);
grid on;