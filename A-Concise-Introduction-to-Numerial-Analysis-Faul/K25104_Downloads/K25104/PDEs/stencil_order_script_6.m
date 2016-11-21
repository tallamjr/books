% Usage example for stencil_order
% related to Exercise 8.6

A = [0 0 1 0 0;
    0 2 -8 2 0;
    1 -8 20 -8 1;
    0 2 -8 2 0;
    0 0 1 0 0];
order = 6;
[ final ] = stencil_order( A,order )