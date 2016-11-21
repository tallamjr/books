% Usage example for basic_power
% related to Exercise 2.22

A = [1 1 1;
    1 1 0;
    1 0 1];
tol = 1e-6;

[ v,c,k ] = basic_power( A,tol )