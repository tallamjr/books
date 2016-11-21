% Usage example for Forward
% related to Exercise 2.2 

L = [8 0 0 0;
     6 2 0 0;
     -2 -1 -3/4 0
     1 -1 3 1/2];

c = [8/3;
    -2;
    2;
    -2];

[x] = Backward(L,c)