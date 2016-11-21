function [ Q ] = gauss_legendre_rule( f,a,b,n )
% Employs Gauss-Legendre rule to integrate f between a and b
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
legendre=legendreP(n,x);    % look up the n-th Legendre polynomial
legendre=sym2poly(legendre);% convert symbolic expression to vector of 
                            % polynomial coefficents
nodes=roots(legendre);  % roots of the Legendre polynomial

% generate the weights by integrating the  
% Lagrange interpolating polynomials
weights = zeros(n); 
syms L; % symbolic variable to hold Lagrange polynomial
for k=1:n;
    L = Lagrangecardinal( nodes,k );
    weights(k) = int(L,x,-1,1);
end

Q=0;    % initialize Q

% evaluate the quadrature 
% shifting the nodes to the interval [a,b]
nodes = (b-a)/2* nodes + (a+b)/2 * ones(n,1);
for i=1:n;
    Q=Q+weights(i)*feval(f,nodes(i));
end
% adjusting the weights by a factor of (b-a)/2
Q=(b-a)/2*Q;

end

