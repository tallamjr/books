% Usage example for QRalg_Householder

A = [1 -1 0 0; 
    1 1 -1 0; 
    0 1 1 -1; 
    0 0 1 1];
tol = 1e-6;

[ D,k ] = QRalg_Householder( A,tol )