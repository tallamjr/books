% Usage example for Gaussian_elementary
% related to Exercise 2.2 

A = [8 6 -2 1;
    8 8 -3 0;
    -2 2 -2 1;
    4 3 -2 5];

b = [-2;
    0;
    2;
    -1];

[U,c] = Gaussian_elementary(A,b);

x = Backward(U,c)