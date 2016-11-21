% Usage example for Gauss_Seidel
% related to Exercise 2.13

A = [100 -11;
    9 1];
b = [111;
    10];
x0 = zeros(2,1);
w = 200/299;
imax = 100;

[ x,k,H,E ] = Gauss_Seidel( A,b,x0,w,imax )