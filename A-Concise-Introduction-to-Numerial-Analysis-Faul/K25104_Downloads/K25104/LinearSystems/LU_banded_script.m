% Usage example for LU_banded
% related to Exercise 2.6 

A = [1 1 0 0 0 0;
    1 2 1 0 0 0;
    0 1 2 1 0 0;
    0 0 1 3 1 0;
    0 0 0 1 3 1;
    0 0 0 0 1 4];

[L,U] = LU_banded(A,1)