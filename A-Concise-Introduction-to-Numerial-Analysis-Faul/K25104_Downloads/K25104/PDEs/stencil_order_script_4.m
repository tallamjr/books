% Usage example for stencil_order
% expansion of the 9-point stencil

A = [1/6 2/3 1/6;
    2/3 -10/3 2/3;
    1/6 2/3 1/6];
order = 6;
[ final ] = stencil_order( A,order )