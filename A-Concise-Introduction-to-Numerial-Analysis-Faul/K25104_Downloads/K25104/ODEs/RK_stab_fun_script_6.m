% Usage example for RK_stab_fun
% related to Exercise 6.15

alpha = 1/3;
b = [1/2; 1/2];
c = [0; 1];
A = [0 0;
    1-alpha alpha];
[ R ] = RK_stab_fun( b,c,A )
[X,Y] = meshgrid(-7:0.1:0.5,-5:0.1:5);
Z = X+1i*Y;
Rmod = abs(R);
Rmod = matlabFunction(Rmod);
boundary = feval(Rmod,Z);
contour(X,Y,boundary,[1 1]);
grid on;
title(['Exercise 6.15']);
