% Usage example for RK_order
% related to Exercise 6.19

b = [1/2; 1/2];
c = [0; 1];
A = [0 0;
    1 0];
[ p ] = RK_order( b,c,A )
a = 1;
c = [0; 2*a];
A = [0 0;
    a a];
[ p ] = RK_order( b,c,A )
