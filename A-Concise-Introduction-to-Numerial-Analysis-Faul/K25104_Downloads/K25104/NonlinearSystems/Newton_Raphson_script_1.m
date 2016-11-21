% Usage example for Newton_Raphson
% related to Exercise 4.6

p = [ 1 1 0 -2];
initial = 1.5;
tol = 1e-6;
max = 100;
[ x,k ] = Newton_Raphson( p,initial,tol,max )