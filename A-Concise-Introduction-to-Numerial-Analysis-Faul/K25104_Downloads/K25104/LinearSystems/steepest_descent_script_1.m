% Usage example for steepest_descent
% related to Exercise 2.15

A = [1 0 0;
    0 2 0;
    0 0 3];
b = [1;
    1;
    1];
tol = 1e-6;

[ x,k ] = steepest_descent( A,b,tol )
