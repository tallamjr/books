% Usage example for shifted_power

A = [100 1 0;
0 101 1;
0 0 102];
s = 100.5;
tol = 1e-6;

[ v,c,k ] = shifted_power( A,s,tol )