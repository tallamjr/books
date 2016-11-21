% Usage example for LU
% related to Exercise 2.2 

A = [8 6 -2 1;
    8 8 -3 0;
    -2 2 -2 1;
    4 3 -2 5];

b = [-2;
    0;
    2;
    -1];

[L,U]=LU(A);

y = Forward(L,b);
x = Backward(U,y)