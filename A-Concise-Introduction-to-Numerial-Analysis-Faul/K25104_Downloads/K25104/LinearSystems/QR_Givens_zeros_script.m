% Usage example for QR_Givens_zeros
% related to Exercise 2.8 

A = [3 6 -1;
    -6 -6 1;
    0 1 -1];

v = zeros(3);
v(3) = 1;

[ Q, R ] = QR_Givens_zeros( A,v )