% Usage example for forward_euler
% related to question 6.7

f = @(t,y) -10^2*(y - t^(-1)) - t^(-2);
% Note that the exponent has changed for illustration purposes
t0 = 1;
y0 = 1;
h = 0.022;
% In theory we need h < 0.02 to ensure the error remains small
T = 2;
analytic = @(t) t.^(-1);
[ y,t,err ] = forward_euler( f,t0,y0,h,T,analytic );
figure;
plot(t,y,'o');           
xlabel('t');
ylabel('y(t)');
hold on;
ezplot(analytic, [1 2]);
legend('numerical','analytic');
