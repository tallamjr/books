% Usage example for RK_stab_fun
% Boundary of stability domain of Heun's method

alpha = 1;
b = [1 - 1/(2*alpha); 1/(2*alpha)];
c = [0; alpha];
A = [0 0;
    alpha 0];
[ R ] = RK_stab_fun( b,c,A )
[X,Y] = meshgrid(-2.5:0.1:0.5,-2:0.1:2);
Z = X+1i*Y;
Rmod = abs(R);
Rmod = matlabFunction(Rmod);
boundary = feval(Rmod,Z);
contour(X,Y,boundary,[1 1]);
grid on;
title(['Heun',char(39),'s rule']);
