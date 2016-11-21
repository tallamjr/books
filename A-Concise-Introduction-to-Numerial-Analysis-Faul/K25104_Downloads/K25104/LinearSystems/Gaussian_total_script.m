% Usage example for Gaussian_total

A = hilb(4);

b = [4;
    3;
    2;
    1];

[U,c,P] = Gaussian_total(A,b);

y = Backward(U,c);

x = P*y    % Remember P' = P and P'*P = I