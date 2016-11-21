% Usage example for RK_order
% related to Exercise 6.11

b = [1/8; 3/8; 3/8; 1/8];
c = [0; 1/3; 2/3; 1];
A = [0 0 0 0;
    1/3 0 0 0;
    -1/3 1 0 0;
    1 -1 1 0];
[ p ] = RK_order( b,c,A )