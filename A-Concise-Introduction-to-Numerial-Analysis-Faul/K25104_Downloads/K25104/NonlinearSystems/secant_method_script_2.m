% Usage example for secant_method
% related to Exercise 4.7

pt = 2;
K = 1;
f = @(x) x/(1-x) * sqrt(2*pt/(2+x)) - K;
a = 0;
b = 0.9;
tol = 1e-6;
max = 100;
[ x,k ] = secant_method( f,a,b,tol,max )