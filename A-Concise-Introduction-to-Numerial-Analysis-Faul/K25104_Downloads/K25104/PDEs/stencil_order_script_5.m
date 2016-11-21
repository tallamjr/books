% Usage example for stencil_order
% related to Exercise 8.5

A = [-1/4 0 1/4;
    0 0 0;
    1/4 0 -1/4];
order = 6;
[ final ] = stencil_order( A,order )