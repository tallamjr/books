% Usage example for RK_stab_fun
% Boundary of stability domain of Nystrom's method

b = [1/4; 3/8; 3/8];
c = [0; 2/3; 2/3];
A = [0 0 0;
     2/3 0 0;
     0 2/3 0];
[ R ] = RK_stab_fun( b,c,A )
[X,Y] = meshgrid(-3:0.1:0.5,-3:0.1:3);
Z = X+1i*Y;
Rmod = abs(R);
Rmod = matlabFunction(Rmod);
boundary = feval(Rmod,Z);
contour(X,Y,boundary,[1 1]);
grid on;
title(['Nystrom',char(39),'s method']);
