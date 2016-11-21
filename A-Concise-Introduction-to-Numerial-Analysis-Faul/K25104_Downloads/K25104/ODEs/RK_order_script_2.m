% Usage example for RK_order
% related to Exercise 6.15

alpha = 1/3;
b = [1/2; 1/2];
c = [0; 1];
A = [0 0;
    1-alpha alpha];
[ p ] = RK_order( b,c,A )