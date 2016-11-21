function [ p ] = multistep_order( rho,sigma )
% Computes the order of the multistep method defined by the coefficients in rho and sigma.
% Input arguments:
%   rho, sigma, column vectors prescribing the method. 
%     The first element should contain the coefficient associated with l=0.
% Output arguments:
%   p, order of the method

% check user inputs
[n,m]=size(rho);    % finding the size of rho
[s,t]=size(sigma);  % finding the size of sigma
if m~=1 || t~=1;
    error('inputs must be column vectors');
elseif n~=s;
    error('input vectors must be the same length');
end

if sum(rho)~=0;
    disp(['first order condition not satisfied']);
    p=0; return;
end

k=1;    % initialize k
term=0; 

while term==0;
    a=0; b=0;   % initialize a,b
    for l=0:s-1;
        a=a+(l^k)*rho(l+1);
        b=b+(l^(k-1))*sigma(l+1);
    end
    b=k*b;
    if abs(a-b)<1e-12;  % not comparing to zero incase of rounding errors
        k=k+1;
    else
        term=1;
    end
end

p=k-1;

end
        

