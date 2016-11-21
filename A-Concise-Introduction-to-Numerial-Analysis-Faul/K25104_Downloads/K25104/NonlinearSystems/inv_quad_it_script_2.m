% Usage example for inv_quad_it
% related to Exercise 4.7

pt = 2;
K = 1;
f = @(x) x/(1-x) * sqrt(2*pt/(2+x)) - K;
x0 = 0;
x1 = 0.2;
x2 = 0.9;
tol = 1e-6;
max = 100;
[ x,k ] = inv_quad_it( f,x0,x1,x2,tol,max )