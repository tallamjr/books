% Usage example for Gaussian_partial

A = [0 1 0 0;
    1 0 3 0;
    -1/2 0 -1/5 1;
    -1/2 -3/10 1 0];

b = [10;
    17;
    -1;
    1];

[U,c] = Gaussian_partial(A,b);

x = Backward(U,c)