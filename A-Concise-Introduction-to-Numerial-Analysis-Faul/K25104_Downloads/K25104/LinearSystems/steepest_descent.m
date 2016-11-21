function [ x,k ] = steepest_descent( A,b,tol )
% Implements method of steepest descent to find the solution of Ax=b.
% Input arguments:
%   A, symmetric positive definite matrix
%   b, column vector
%   tol, convergence is accepted when |Ax-b|<tol
% Output arguments:
%   x, solution to Ax=b
%   k, number of iterations

[n,m]=size(A); % finding the size of A
[p,q]=size(b); % finding the size of b
if n~= m;
    error('first input is not a square matrix');
elseif q~=1;
    error('second input is not a column vector');
elseif p~=n;
    error('input dimensions do not agree');
elseif tol<=0;
    error('tolerance should be positive');
elseif ~issymmetric(A);
    error('first input is not symmetric');
else
    [~,a] = chol(A);
    if a
        error('first input is not positive definite');
    end
end

x=zeros(n,1);  % initialize x
g=-b; % initialize gradient, the negative of the steepest descent direction
k=0;  % initialize counter

while sqrt(g'*g)>tol;
    w=g'*g/(g'*A*g);    % calculate step size in the descent direction
    x=x-w*g;            % update x
    g=A*x-b;            % update g
    k=k+1;              % increment counter
end
    
end

