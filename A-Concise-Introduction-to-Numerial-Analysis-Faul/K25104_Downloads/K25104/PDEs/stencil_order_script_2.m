% Usage example for stencil_order

A = [0 0 -1/12 0 0;
    0 0 4/3 0 0;
    -1/12 4/3 -5 4/3 -1/12;
    0 0 4/3 0 0;
    0 0 -1/12 0 0];
order = 6;
[ final ] = stencil_order( A,order )