% Usage example for deflation_Householder_1
% related to Exercise 2.19

A = [3 2 4;
    2 0 2;
    4 2 3];
v = [2;
    1;
    2];

[ D ] = deflation_Householder_1( A,v )