% Usage example for Halley
% related to Exercise 4.6

p = [ 1 1 0 -2];
initial = -0.5;
tol = 1e-6;
max = 100;
[ x,k ] = Halley( p,initial,tol,max )