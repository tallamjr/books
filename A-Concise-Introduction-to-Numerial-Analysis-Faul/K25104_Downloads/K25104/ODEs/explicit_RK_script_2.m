% Usage example for explicit_RK
% employing the original Runge-Kutta method

f = @(t,y) -10^2*(y - t^(-1)) - t^(-2);
t0 = 1;
y0 = 1;
h = 0.029;
% no increase in error if h =0.028
T = 2;
b = [1/6; 1/3; 1/3; 1/6];
c = [0; 1/2; 1/2; 1];
A = [0 0 0 0;
    1/2 0 0 0;
    0 1/2 0 0;
    0 0 1 0];
analytic = @(t) t.^(-1);
[ y,t,err ] = explicit_RK( f,t0,y0,h,T,b,c,A,analytic );
figure;
plot(t,y,'o');           
xlabel('t');
ylabel('y(t)');
hold on;
ezplot(analytic, [1 2]);
legend('numerical','analytic');
