% Usage example for cubic_spline
% related to Figure 3.1

x = (-1:0.01:1)';
[~,xn] = size(x);
y = ones(xn)./(ones(xn)+25*x.^2);
plot(x,y,'k')  % plot Runge's example
hold;
n = 8;
inter = 2/n;
nodes = (-1:inter:1)';
values = ones(n+1,1)./(ones(n+1,1)+25*nodes.^2);
a=0; b=0;
[y] = cubic_spline( nodes,values,a,b,x );
plot(x,y)  % plot the interpolant
plot(nodes, values,'o')    % plot the data

