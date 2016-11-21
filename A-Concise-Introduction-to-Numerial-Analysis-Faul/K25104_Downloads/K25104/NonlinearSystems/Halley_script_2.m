% Usage example for Halley
% related to Exercise 4.7

pt = 2;
K = 1;
syms x;
f = x/(1-x) * sqrt(2*pt/(2+x)) - K;
initial = 0.7;
tol = 1e-6;
max = 100;
[ x,k ] = Halley( f,initial,tol,max )