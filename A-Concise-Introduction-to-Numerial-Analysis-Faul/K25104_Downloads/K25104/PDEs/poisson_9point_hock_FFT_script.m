% Usage example for poisson_9point_hock_FFT

f = @(x,y) 6*x.*y.*(1-y)-2*x.^3;
g = @(x,y) y.*(1-y).*x.^3;
a = 0;
b = 1;
N= 31;
[ soln, timer ] = poisson_9point_hock_FFT( f,g,a,b,N );
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