% Usage example for iteration_analysis
% related to Exercise 2.29 

B = [0 sqrt(3)/2 1/2;
    sqrt(3)/2 0 sqrt(3)/2;
    1/2 sqrt(3)/2 0];
C = [2 0 0;
    0 2 0;
    0 0 2];
w = 8/9;

[ H,E ] = iteration_analysis( C,B,w )