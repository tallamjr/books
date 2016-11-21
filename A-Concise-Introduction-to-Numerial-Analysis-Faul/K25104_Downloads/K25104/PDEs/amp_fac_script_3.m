% Usage example for amp_fac
% related to Exercise 8.17

syms mu;
alpha = [1-2*mu; 4*mu; 1-2*mu];
beta = [1; 0; 1];
r = 1;
s = 1;
[ H ] = abs(amp_fac( alpha, beta,r,s ));
figure;
x = -pi:0.05:pi;
H = matlabFunction(H);
Hphi =@(phi) H(0.4,phi);
y = Hphi(x);
plot(x,y);
ax = gca;
ax.XTick = [-pi -pi/2 0 pi/2 pi];
ax.XTickLabel = {'-\pi','-\pi/2','0','\pi/2','\pi'};
hold on;

Hphi =@(phi) H(0.5,phi);
y = Hphi(x);
plot(x,y);

Hphi =@(phi) H(1,phi);
y = Hphi(x);
plot(x,y);

Hphi =@(phi) H(10,phi);
y = Hphi(x);
plot(x,y);

legend('\mu = 0.4','\mu = 0.5', '\mu = 1', '\mu = 10');
title('modulus of amplification factor');
line([-4 4],[1 1],'Color','k','LineStyle',':');