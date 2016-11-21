function [ Q ] = left_gauss_radau_rule( f,a,b,n )
% Employs the left Gauss-Radau rule with n abscissae to integrate f between a and b
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
leg1=legendreP(n,x);       % look up the necessary legendre polynomials
leg0=legendreP(n-1,x);

nodes=(leg0+leg1);  % construct function whose roots give the nodes
nodes=sym2poly(nodes);     % convert symbolic expression to polynomial
nodes=roots(nodes);        % find roots
[~,index]=min(nodes);    % find index of element in nodes which equals -1
% remove the end point entry, to get interior abscissae
nodes=[nodes(1:(index-1));nodes((index+1):n)];  
leg0=sym2poly(leg0);    % convert symbolic expression to polynomial

weights=zeros(n-1,1);   % initialize vector to hold weights
for k=1:n-1;
    temp=polyval(leg0,nodes(k)); % evaluate legendre polynomial at the knot
    weights(k)=(1-nodes(k))/((n*temp)^2);   % calculate weights
end

% evaluate the quadrature
Q=2*feval(f,a)/(n*n);  % end point contribution

for i=1:n-1;    % add the contributions from interior nodes
    Q=Q+weights(i)*feval(f,(b-a)*nodes(i)/2+(a+b)/2);   
end
% adjusting the weights by a factor of (b-a)/2
Q=(b-a)/2*Q;

end
