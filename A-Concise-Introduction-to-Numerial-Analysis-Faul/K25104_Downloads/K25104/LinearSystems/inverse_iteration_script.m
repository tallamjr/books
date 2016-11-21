% Usage example for inverse_iteration
% related to Exercise 2.22

A = [1 1 1;
    1 1 0;
    1 0 1];
s = 2.5;
tol = 1e-6;

[ v,c,k ] = inverse_iteration( A,s,tol )