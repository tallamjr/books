function [ Q ] = gauss_lobatto_rule( f,a,b,n )
% Employs Gauss-Lobatto rule with Legendre polynomials 
% to integrate f between a and b
% Input arguments:
%   f, function handle
%   a,b, integration bounds, a<b
%   n, number of abscissae
% Output arguments:
%   Q, value of integral 

% first check user inputs
if isa(f,'function_handle')==0;
    error('input must be a function handle');
elseif a>=b;
    error('invalid interval');
elseif mod(n,1)~=0 || n<=0; % if n does not equal zero modulo 1 then it  
                            % is not an integer value
    error('input must be a positive integer');
end

syms x;     % create a symbolic variable
legendre=legendreP(n-1,x); % look up the necessary legendre polynomial
dlegendre = diff(legendre);
legendre=sym2poly(legendre);    % convert symbolic expression to vector of 
                                % polynomial coefficents
dlegendre=sym2poly(dlegendre);
nodes = roots(dlegendre); % interior abscissae

weights=zeros(n-2,1);   % initialize vector to hold weights
for k=1:n-2;
    temp=polyval(legendre,nodes(k));
    weights(k)=2/(n*(n-1)*(temp^2));
end

% evaluate the quadrature
% evaluate the end point contribution
Q=2*(feval(f,b)+feval(f,a))/(n*(n-1));  

for i=1:n-2;    % add the contribution from interior knots
    Q=Q+weights(i)*feval(f,(b-a)*knots(i)/2+(a+b)/2);   
end
% adjusting the weights by a factor of (b-a)/2
Q=(b-a)/2*Q;

end



