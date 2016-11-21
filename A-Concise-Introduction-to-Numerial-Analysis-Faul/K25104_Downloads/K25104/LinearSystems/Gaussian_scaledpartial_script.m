% Usage example for Gaussian_scaledpartial

A = hilb(4);

b = [4;
    3;
    2;
    1];

[U,c] = Gaussian_scaledpartial(A,b);

x = Backward(U,c)