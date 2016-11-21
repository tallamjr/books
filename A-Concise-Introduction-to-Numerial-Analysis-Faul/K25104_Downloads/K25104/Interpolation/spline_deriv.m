function [ d ] = spline_deriv( nodes, values, a,b )
% Calculates the derivatives of the cubic spline at the interior nodes.
% Input arguments: 
%   nodes, column vector holding the positions of the nodes
%   values, column vector holding function values at the nodes
%   a,b, values of the the derivatives at the endpoints
% Output arguments:
%   d, column vector holding the derivatives of the spline at the nodes

[n,m]=size(nodes);   % finding the size of nodes 
[p,q]=size(values);  % finding the size of values 
if m~=1 || q~=1
    error('inputs must be column vectors');
elseif n~=p
    error('input vectors must be the same length');
end

diagonal=zeros(n-2,1);  % initialise vector to hold diagonal
for k=1:n-2;
    diagonal(k)=2/(nodes(k+1)-nodes(k))+2/(nodes(k+2)-nodes(k+1));
end

sup_diag=zeros(n-3,1);  % initialise vector to hold off diagonal
for k=1:n-3
    sup_diag(k)=1/(nodes(k+1)-nodes(k));
end

S=diag(diagonal)+diag(sup_diag,1)+diag(sup_diag,-1);    % form S

V=zeros(n-2,1); % initialise vector for right hand side
for k=1:n-2;
    V(k)=3*(values(k+1)-values(k))/((nodes(k+1)-nodes(k))^2)+...
        3*(values(k+2)-values(k+1))/((nodes(k+2)-nodes(k+1))^2);
end 
V(1)=V(1)-a/(nodes(2)-nodes(1));
V(n-2)=V(n-2)-b/(nodes(n-1)-nodes(n-2));

d=linsolve(S,V);    % solve linear system

end

