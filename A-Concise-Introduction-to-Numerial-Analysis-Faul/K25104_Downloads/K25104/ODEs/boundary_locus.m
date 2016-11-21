function [ z ] = boundary_locus( rho,sigma,n )
% Uses the boundary locus method to identify the boundary 
% of the linear stability region of the general multistep method 
% described by the polynomials rho and sigma.
% Input arguments:
%   rho, sigma, column vectors whose elements are the coefficients
%     of the defining polynomials in descending powers.
%   n, number of plot points
% Output arguments:
%   z, points on paramterised curve

% check user inputs 
[a,b]=size(rho);
[c,d]=size(sigma);
if b~=1 || d~=1;
    error('inputs must be column vectors');
elseif a~=c;
    error('inputs must be the same length');
end

x=linspace(0,2*pi,n);    % initialize range of the parameter

num = polyval(rho,exp(1i*x));
denom = polyval(sigma, exp(1i*x));
z = num./denom;
end



