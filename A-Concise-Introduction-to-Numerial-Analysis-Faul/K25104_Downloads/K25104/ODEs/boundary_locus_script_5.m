% Usage example for boundary_locus
% related to the Backward Differentiation Formulae

n=100;
subplot(3,2,1);
rho = [1; -1];
sigma = [1; 0];
[ z ] = boundary_locus( rho,sigma,n );
plot(z);
title('1-step BDF method');
axis([-1/2 5/2 -3/2 3/2]);
grid on;

subplot(3,2,2);
rho = [1; -4/3; 1/3];
sigma = [2/3; 0; 0];
[ z ] = boundary_locus( rho,sigma,n );
plot(z);
title('2-step BDF method');
axis([-1/2 9/2 -5/2 5/2]);
grid on;

subplot(3,2,3);
rho = [1; -18/11; 9/11; -2/11];
sigma = [6/11; 0; 0; 0];
[ z ] = boundary_locus( rho,sigma,n );
plot(z);
title('3-step BDF method');
axis([-1/2 7 -9/2 9/2]);
grid on;

subplot(3,2,4);
rho = [1; -48/25; 36/25; -16/25; 3/25];
sigma = [12/25; 0; 0; 0; 0];
[ z ] = boundary_locus( rho,sigma,n );
plot(z);
title('4-step BDF method');
axis([-1 11 -8 8]);
grid on;

subplot(3,2,5);
rho = [1; -300/137; 300/137; -200/137; 75/137; -12/137];
sigma = [60/137; 0; 0; 0; 0; 0];
[ z ] = boundary_locus( rho,sigma,n );
plot(z);
title('5-step BDF method');
axis([-4 19 -15 15]);
grid on;

subplot(3,2,6);
rho = [1; -360/147; 450/147; -400/147; 225/147; -72/147; 10/147];
sigma = [60/147; 0; 0; 0; 0; 0; 0];
[ z ] = boundary_locus( rho,sigma,n );
plot(z);
title('6-step BDF method');
axis([-10 30 -25 25]);
grid on;