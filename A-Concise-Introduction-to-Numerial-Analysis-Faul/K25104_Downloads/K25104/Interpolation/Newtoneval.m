function [y] = Newtoneval(nodes, values, x )
% Evaluates the interpolating polynomial for the given data
% from the Newton form.
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

d=divdifftable(nodes,values);   % this subroutine calculates the divided 
                                % difference table
d=diag(d);  % the required divided differences lie along the diagonal

y = d(1) * ones(p,1); % first term of the sum in the Newton form
temp = x - nodes(1) * ones(p,1); % temp holds the product
% Note that y and temp are vectors

% add the terms of the sum in the Newton form one after the other
for i=2:n
    y = y + d(i) * temp;
    temp = temp .* (x - nodes(i)); % Note: .* is element-wise multiplication
end
end

