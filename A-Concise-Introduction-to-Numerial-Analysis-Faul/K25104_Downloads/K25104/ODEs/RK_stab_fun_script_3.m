% Usage example for RK_stab_fun
% Boundary of stability domain of Kutta's method

b = [1/6; 2/3; 1/6];
c = [0; 1/2; 1];
A = [0 0 0;
     1/2 0 0;
     -1 2 0];
[ R ] = RK_stab_fun( b,c,A )
[X,Y] = meshgrid(-3:0.1:0.5,-3:0.1:3);
Z = X+1i*Y;
Rmod = abs(R);
Rmod = matlabFunction(Rmod);
boundary = feval(Rmod,Z);
contour(X,Y,boundary,[1 1]);
grid on;
title(['Kutta',char(39),'s method']);
