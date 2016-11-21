% Usage example for steepest_descent

A = [3 1 0 0;
    1 4 1 3;
    0 1 10 0;
    0 3 0 3];
b = [1;
    1;
    1;
    1];
tol = 1e-6;

[ x,k ] = steepest_descent( A,b,tol )
