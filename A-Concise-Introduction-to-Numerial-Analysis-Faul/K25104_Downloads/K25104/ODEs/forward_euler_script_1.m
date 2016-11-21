% Usage example for forward_euler
% related to question 6.1

f = @(t,y) -y/(1+t);
t0 = 0;
y0 = 1;
h = 0.1;
T = 1;
analytic = @(t) 1./(1+t);
[ y,t,err ] = forward_euler( f,t0,y0,h,T,analytic );
figure;
plot(t,y,'o');           
xlabel('t');
ylabel('y(t)');
hold on;
ezplot(analytic, [0 1]);
legend('numerical','analytic');
f = @(t,y) 2*y/(1+t);
analytic = @(t) (1+t).^2;
[ y,t,err ] = forward_euler( f,t0,y0,h,T,analytic );
figure;
plot(t,y,'o');           
xlabel('t');
ylabel('y(t)');
hold on;
ezplot(analytic, [0 1]);
legend('numerical','analytic');


