% Usage example for RK_stab_fun
% related to Exercise 6.19

b = [1/2; 1/2];
c = [0; 1];
A = [0 0;
    1 0];
[ R ] = RK_stab_fun( b,c,A )
[X,Y] = meshgrid(-2.5:0.1:2.5,-2:0.1:2);
Z = X+1i*Y;
Rmod = abs(R);
Rmod = matlabFunction(Rmod);
boundary = feval(Rmod,Z);
contour(X,Y,boundary,[1 1]);
hold on;
a = 1;
c = [0; 2*a];
A = [0 0;
    a a];
[ R ] = RK_stab_fun( b,c,A )
Rmod = abs(R);
Rmod = matlabFunction(Rmod);
boundary = feval(Rmod,Z);
contour(X,Y,boundary,[1 1]);
grid on;
title(['Exercise 6.19']);
