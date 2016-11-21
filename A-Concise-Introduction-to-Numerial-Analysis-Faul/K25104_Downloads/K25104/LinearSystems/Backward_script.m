% Usage example for Backward
% related to Exercise 2.2 

U = [8 6 -2 1;
    0 2 -1 -1;
    0 0 -3/4 3;
    0 0 0 1/2];

c = [-2;
    2;
    -2;
    8/3];

[x] = Backward(U,c);