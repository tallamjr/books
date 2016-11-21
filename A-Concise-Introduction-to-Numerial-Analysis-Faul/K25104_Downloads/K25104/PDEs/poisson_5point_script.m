% Usage example for poisson_5point

f = @(x,y) 1.25*exp(x+y/2);
g = @(x,y) exp(x+y/2);
a = 0;
b = 1;
N= 31;
[ soln, timer ] = poisson_5point( f,g,a,b,N );
h=(b-a)/(N+1);
X = 0:h:1;
Y = 0:h:1;
Z = zeros(N+2,N+2);
Z(1,:) = g(X,zeros(1,N+2));
Z(N+2,:) = g(X,ones(1,N+2));
Z(:,1) = g(zeros(1,N+2),Y);
Z(:,N+2) = g(ones(1,N+2),Y);
Z(2:N+1,2:N+1) = soln;
surf(X,Y,Z);