% Usage example for implicit_multistep
% employing 3-step Adams-Moulton method

f = @(t,y) -y/(1+t);
t0 = 0;
y0 = 1;
h = 0.1;
T = 1;
rho = [0; 0; -1; 1];
sigma = [1/24; -5/24; 19/24; 3/8];
analytic = @(t) 1./(1+t);
[ y,t,err ] = implicit_multistep( f,t0,y0,h,T,rho, sigma, analytic );
figure;
plot(t,y,'o');           
xlabel('t');
ylabel('y(t)');
hold on;
ezplot(analytic, [0 1]);
legend('numerical','analytic');
f = @(t,y) 2*y/(1+t);
analytic = @(t) (1+t).^2;
[ y,t,err ] = implicit_multistep( f,t0,y0,h,T,rho, sigma, analytic );
figure;
plot(t,y,'o');           
xlabel('t');
ylabel('y(t)');
hold on;
ezplot(analytic, [0 1]);
legend('numerical','analytic');


