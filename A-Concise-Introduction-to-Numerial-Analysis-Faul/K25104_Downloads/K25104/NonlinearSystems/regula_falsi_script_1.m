% Usage example for regula_falsi
% related to Exercise 4.6

p = [ 1 1 0 -2];
a = 0.2;
b = 1.5;
tol = 1e-6;
max = 100;
[ x,k ] = regula_falsi( p,a,b,tol,max )