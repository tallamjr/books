% Usage example for explicit_RK
% employing the original Runge-Kutta method

f = @(t,y) -y/(1+t);
t0 = 0;
y0 = 1;
h = 0.1;
T = 1;
b = [1/6; 1/3; 1/3; 1/6];
c = [0; 1/2; 1/2; 1];
A = [0 0 0 0;
    1/2 0 0 0;
    0 1/2 0 0;
    0 0 1 0];
analytic = @(t) 1./(1+t);
[ y,t,err ] = explicit_RK( f,t0,y0,h,T,b,c,A,analytic );
figure;
plot(t,y,'o');           
xlabel('t');
ylabel('y(t)');
hold on;
ezplot(analytic, [0 1]);
legend('numerical','analytic');
f = @(t,y) 2*y/(1+t);
analytic = @(t) (1+t).^2;
[ y,t,err ] = explicit_RK( f,t0,y0,h,T,b,c,A,analytic );
figure;
plot(t,y,'o');           
xlabel('t');
ylabel('y(t)');
hold on;
ezplot(analytic, [0 1]);
legend('numerical','analytic');


