function [ y ] = Lagrangeeval( nodes,values,x )
% Evaluates the interpolating polynomial for the given data 
% from the Lagrange form.
% Input arguments:
%   nodes, the interpolation nodes
%   values, function values at the nodes
%   x, values at which the interpolating polynomial should be evaluated
% Output arguments:
%   y, value of interpolating polynomial at x

[n,m]=size(nodes);  % finding the size of nodes
[k,l]=size(values); % finding the size of values
[p,q]= size(x);     % finding the size of x
if m~=1 || l~=1 || q~=1;
    error('input need to be column vectors');
elseif n~=k
    error('input dimensions do not agree');
end

y=zeros(p,1);   % initialise y
for k=1:n;
    prod=ones(p,1); % initalise vector to hold product
    for l=1:n
        if l==k;    % do nothing
        else        % update product
            prod=prod.*(x-nodes(l)*ones(p,1))/(nodes(k)-nodes(l));
        end
    end
    y=y+values(k)*prod;   % update sum
end

end

