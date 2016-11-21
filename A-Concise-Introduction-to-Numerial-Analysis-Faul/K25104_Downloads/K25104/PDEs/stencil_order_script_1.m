% Usage example for stencil_order
% expansion of the 5-point stencil

A = [0 1 0;
    1 -4 1;
    0 1 0];
order = 6;
[ final ] = stencil_order( A,order )