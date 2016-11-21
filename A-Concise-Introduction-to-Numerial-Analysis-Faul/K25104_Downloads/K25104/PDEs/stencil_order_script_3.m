% Usage example for stencil_order
% related to Exercise 8.20

A = [1/2 0 1/2;
    0 -2 0;
    1/2 0 1/2];
order = 6;
[ final ] = stencil_order( A,order )