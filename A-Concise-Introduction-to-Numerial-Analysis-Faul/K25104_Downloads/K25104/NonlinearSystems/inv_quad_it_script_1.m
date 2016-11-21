% Usage example for inv_quad_it
% related to Exercise 4.6

p = [ 1 1 0 -2];
x0 = 0.1;
x1 = 0.7;
x2 = 1.5;
tol = 1e-6;
max = 100;
[ x,k ] = inv_quad_it( p,x0,x1,x2,tol,max )