function [ y ] = Newton_Horner( nodes,values,x )
% Evaluates the interpolating polynomial for the given data 
% from the Newton form, utilising the Horner scheme.
% Input arguments:
%   nodes, the interpolation nodes
%   values, function values at the nodes
%   x, values at which the interpolating polynomial should be evaluated
% Output arguments:
%   y, value of interpolating polynomial at x

[n,m]=size(nodes);      % finding the size of nodes
[k,l]=size(values);     % finding the size of values
[p,q]= size(x);         % finding the size of x
if m~=1 || l~=1 || q~=1;
    error('input need to be column vectors');
elseif n~=k
    error('input dimensions do not agree');
end

d=divdifftable(nodes,values);   % this subroutine calculates the divided 
                                % difference table
d=diag(d);  % the required divided differences lie along the diagonal

y=d(n)*ones(p,1);   % set y equal to the most deeply nested  
                    % term in the expression

for i=1:n-1; % expand out the brackets one after the other
    y=y.*(x-nodes(n-i)*ones(p,1))+d(n-i)*ones(p,1); 
end

end

