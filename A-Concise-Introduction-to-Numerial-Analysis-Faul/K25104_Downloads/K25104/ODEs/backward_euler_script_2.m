% Usage example for backward_euler
% related to question 6.7

f = @(t,y) -10^6*(y - t^(-1)) - t^(-2);
t0 = 1;
y0 = 1;
h = 0.1;
T = 2;
analytic = @(t) t.^(-1);
[ y,t,err ] = backward_euler( f,t0,y0,h,T,analytic );
figure;
plot(t,y,'o');           
xlabel('t');
ylabel('y(t)');
hold on;
ezplot(analytic, [1 2]);
legend('numerical','analytic');
