% Usage example for RK_stab_fun
% Example of stability domain boundary for an implicit method

b = [1/4; 3/4];
c = [0; 2/3];
A = [1/4 -1/4;
    1/4 5/12];
[ R ] = RK_stab_fun( b,c,A )
[X,Y] = meshgrid(-1:0.1:7,-5:0.1:5);
Z = X+1i*Y;
Rmod = abs(R);
Rmod = matlabFunction(Rmod);
boundary = feval(Rmod,Z);
contour(X,Y,boundary,[1 1]);
grid on;
title(['implicit example']);
