% Usage example for conjugate_gradient
% related to Exercise 2.15

A = [1 0 0;
    0 2 0;
    0 0 3];
b = [1;
    1;
    1];
tol = 1e-6;

[ x,k ] = conjugate_gradient( A,b,tol )
