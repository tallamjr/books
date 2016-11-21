% Usage example for conjugate_gradient

A = [3 1 0 0;
    1 4 1 3;
    0 1 10 0;
    0 3 0 3];
b = [1;
    1;
    1;
    1];
tol = 1e-6;

[ x,k ] = conjugate_gradient( A,b,tol )
