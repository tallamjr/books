function [ coeffs ] = spline_pieces( nodes,values, derivs )
% Calculates the coefficients of the polynomial pieces 
% which compose a cubic spline on each subinterval
% Input arguments:
%   nodes, column vector holding the positions of the nodes
%   values, column vector holding function values at the nodes
%   derivs, column vector holding derivative values at the nodes
% Output arguments:
%   coeffs, array holding the coefficients of the polynomial 
%     on each subinterval

[n,m]=size(nodes);      % finding the size of nodes 
[p,q]=size(values);       % finding the size of values 
[k,l]=size(derivs);     % finding the sive of derivs
if m~=1 || q~=1 || l~=1
    error('inputs must be column vectors');
elseif n~=p || n~=k
    error('input vectors must be the same length');
end

coeffs=zeros(n-1,4);    % intialise array 

coeffs(:,1)=values(1:n-1);
coeffs(:,2)=derivs(1:n-1);
for j=1:n-1;
    coeffs(j,3)=3*(values(j+1)-values(j))/((nodes(j+1)-nodes(j))^2)...
        -(2*derivs(j)+derivs(j+1))/(nodes(j+1)-nodes(j));
    coeffs(j,4)=2*(values(j)-values(j+1))/((nodes(j+1)-nodes(j))^3)...
        +(derivs(j)+derivs(j+1))/((nodes(j+1)-nodes(j))^2);
end

end

