% Usage example for Brent
% related to Exercise 4.3

p = [ 1 -1 -4 4];
a = -4;
b = 2.5;
tol = 0.01;
max = 100;
[ x,k,z ] = Brent( p,a,b,tol,max );