function [ H ] = amp_fac( alpha, beta,r,s )

% first check user inputs
[a1,a2]=size(alpha);
[b1,b2]=size(beta);
n=r+s+1;
if a2~=1 || b2~=1;
    error('input must be column vectors');
elseif a1~=n || b1~=n;
    error('alpha and beta must be of length (r+s+1)');
end

syms phi;
num=0; denom=0;   % initialise numerator and denominator
for k=1:n;
    num=num+beta(k)*exp(1i*(k-r-1)*phi);
    denom=denom+alpha(k)*exp(1i*(k-r-1)*phi);
end
H=num./denom;
end