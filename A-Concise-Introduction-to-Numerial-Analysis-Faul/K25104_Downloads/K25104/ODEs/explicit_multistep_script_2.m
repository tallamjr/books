% Usage example for explicit_multistep
% employing 3-step Adams-Bashforth method

f = @(t,y) -10^2*(y - t^(-1)) - t^(-2);
t0 = 1;
y0 = 1;
h = 0.0059;
% no increase in error for h = 0.0056
T = 2;
rho = [0; 0; -1; 1];
sigma = [5/12; -4/3; 23/12; 0];
analytic = @(t) t.^(-1);
[ y,t,err ] = explicit_multistep( f,t0,y0,h,T,rho, sigma, analytic );
figure;
plot(t,y,'o');           
xlabel('t');
ylabel('y(t)');
hold on;
ezplot(analytic, [1 2]);
legend('numerical','analytic');
