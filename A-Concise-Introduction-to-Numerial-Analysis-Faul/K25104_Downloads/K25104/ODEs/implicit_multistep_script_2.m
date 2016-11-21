% Usage example for implicit_multistep
% employing 3-step Adams-Moulton method

f = @(t,y) -10^2*(y - t^(-1)) - t^(-2);
t0 = 1;
y0 = 1;
h = 0.1;
T = 2;
rho = [0; 0; -1; 1];
sigma = [1/24; -5/24; 19/24; 3/8];
analytic = @(t) t.^(-1);
[ y,t,err ] = implicit_multistep( f,t0,y0,h,T,rho, sigma, analytic );
figure;
plot(t,y,'o');           
xlabel('t');
ylabel('y(t)');
hold on;
ezplot(analytic, [1 2]);
legend('numerical','analytic');
