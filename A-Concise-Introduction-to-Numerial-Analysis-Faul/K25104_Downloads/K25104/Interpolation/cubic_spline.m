function [ y ] = cubic_spline( nodes,values,a,b,x )
% Fits a cubic spline interpolant to the function at given nodes, and evaluates it at the specified points in x.
% Input arguments:
%   nodes, the interpolation nodes
%   values, function values at the nodes
%   a,b, values of the the derivatives at the endpoints
%   x, points at which the interpolating spline should be evaluated
% Output arguments:
%   y, value of spline at x

[n,m]=size(nodes);   % finding the size of nodes 
[p,q]=size(values);  % finding the size of values 
if m~=1 || q~=1
    error('inputs must be column vectors');
elseif n~=p
    error('input vectors must be the same length');
elseif max(x)>max(nodes) || min(x)<min(nodes)
    error('the interpolant will not be defined at all of the points in x');
end
m=length(x);    % finding the length of x


d=spline_deriv(nodes,values,a,b); % this subroutine calculates the  
                                  % derivatives at the internal nodes.
derivs=[a;d;b];                   % create vector which holds all the 
                                  % derivatives (including endpoints).

coeffs=spline_pieces(nodes,values,derivs); % this subroutine calculates the
                                  % coefficients of the cubic pieces on
                                  % each subinterval
                                   
y=zeros(m,1);   % intialise vector y
k=1;      
for j=1:m;
    point=x(j);
    if point>nodes(k+1) % then the point lies in the next subinterval
        k=k+1;  % increment k
    end 
    temp=point-nodes(k);
    y(j)=coeffs(k,1)+coeffs(k,2)*temp+coeffs(k,3)*temp^2+coeffs(k,4)*temp^3;
end

end

