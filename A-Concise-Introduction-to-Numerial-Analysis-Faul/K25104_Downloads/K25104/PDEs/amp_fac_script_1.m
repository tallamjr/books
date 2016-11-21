% Usage example for amp_fac
% related to Exercise 8.2

syms mu;
alpha = [0; 0; 1; 0; 0];
beta = [-mu*(1-6*mu)/12; 2/3*mu*(2-3*mu); (2-5*mu+6*mu^2)/2; 2/3*mu*(2-3*mu); -mu*(1-6*mu)/12];
r = 2;
s = 2;
[ H ] = abs(amp_fac( alpha, beta,r,s ));
figure;
x = -pi:0.1:pi;
H = matlabFunction(H);
Hphi =@(phi) H(0.7,phi);
y = Hphi(x);
plot(x,y);
ax = gca;
ax.XTick = [-pi -pi/2 0 pi/2 pi];
ax.XTickLabel = {'-\pi','-\pi/2','0','\pi/2','\pi'};
hold on;

Hphi =@(phi) H(2/3,phi);
y = Hphi(x);
plot(x,y);

Hphi =@(phi) H(0.6,phi);
y = Hphi(x);
plot(x,y);

legend('\mu = 0.7','\mu =2/3', '\mu = 0.6');
title('modulus of amplification factor');
line([-4 4],[1 1],'Color','k','LineStyle',':');

mu = 0:0.01:1;
m = length(mu);
mx = zeros(1,m);
for j=1:length(mu)
    Hphi =@(phi) H(mu(j),phi);
    mx(j) = max(Hphi(x));
end
figure;
plot(mu,mx);
ax = gca;
ax.XTick = [0,0.1,0.2,0.3,0.4,0.5,0.6,2/3,0.8,0.9,1];
ax.XTickLabel = {'0','0.1','0.2','0.3','0.4','0.5','0.6','2/3','0.8','0.9','1'};
xlabel('\mu');
title('maximum modulus of amplification factor');
line([2/3 2/3],[0.5 4],'Color','k','LineStyle',':');