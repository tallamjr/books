% Usage example for amp_fac
% related to Exercise 8.12

syms mu;
a = 1/6;
alpha = [-(mu-a)/2; 1+mu-a; -(mu-a)/2];
beta = [(mu+a)/2; 1-mu-a; (mu+a)/2];
r = 1;
s = 1;
[ H ] = abs(amp_fac( alpha, beta,r,s ));
figure;
x = -pi:0.05:pi;
H = matlabFunction(H);
Hphi =@(phi) H(1/3,phi);
y = Hphi(x);
plot(x,y);
ax = gca;
ax.XTick = [-pi -pi/2 0 pi/2 pi];
ax.XTickLabel = {'-\pi','-\pi/2','0','\pi/2','\pi'};
hold on;

Hphi =@(phi) H(1,phi);
y = Hphi(x);
plot(x,y);

Hphi =@(phi) H(10,phi);
y = Hphi(x);
plot(x,y);

legend('\mu = 1/3','\mu =1', '\mu = 10');
title('modulus of amplification factor');
line([-4 4],[1 1],'Color','k','LineStyle',':');
