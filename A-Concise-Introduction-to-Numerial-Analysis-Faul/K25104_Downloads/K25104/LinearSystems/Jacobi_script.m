% Usage example for Jacobi
% related to Exercise 2.29 

A = [2 sqrt(3)/2 1/2;
    sqrt(3)/2 2 sqrt(3)/2;
    1/2 sqrt(3)/2 2];
b = [sqrt(3);
    5/3;
    sqrt(3)];
x0 = zeros(3,1);
w = 8/9;
imax = 100;

[ x,k,H,E ] = Jacobi( A,b,x0,w,imax )