% Usage example for QRalg_Givens

A = [4 5 2 0;
    -26 -14 1 4;
    -2 2 3 1;
    -43 -8 13 9];
tol = 1e-6;

[ D,k ] = QRalg_Givens( A,tol )