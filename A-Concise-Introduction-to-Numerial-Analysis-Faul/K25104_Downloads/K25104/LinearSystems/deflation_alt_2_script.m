% Usage example for deflation_alt_2
% related to Exercise 2.20

A = [1 1/4 0 -3/4;
    3 1/2 2 -1/2;
    0 -3/4 1 1/4;
    2 -1/2 3 1/2];
v1 = [1;
    4;
    1;
    4];
v2 = [-1;
    5;
    -1;
    5];

[ D ] = deflation_alt_2( A,v1,v2 )