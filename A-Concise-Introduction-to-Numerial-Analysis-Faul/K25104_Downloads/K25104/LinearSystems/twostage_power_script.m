% Usage example for twostage_power
% related to Exercise 2.20

A = [1 1/4 0 -3/4;
    3 1/2 2 -1/2;
    0 -3/4 1 1/4;
    2 -1/2 3 1/2];
x0 = [1;
    4;
    1;
    4];
tol = 1e-6;

[ v1,c1,v2,c2,r1,r2,k ] = twostage_power( A,x0,tol )