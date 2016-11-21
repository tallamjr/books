function [ x,k,H,E ] = Gauss_Seidel( A,b,x0,w,imax )
% Solves the linear system Ax=b iteratively using the Gauss-Seidel method.
% Input arguments:
%   A, square matrix
%   b, column vector
%   x0, initial estimate of the solution
%   w, relaxation parameter ( w=1 gives unrelaxed iterations )
%   imax, maximum number of iterations
% Output arguments:
%   x, solution
%   k, number of iterations
%   H, iteration matrix 
%   E, eigenvalues of the iteration matrix

[m,n]=size(A);  % find the size of A
[p,q]=size(b);  % find the size of b
if n~= m
    error('input is not a square matrix');
elseif p~=m || q~=1;  
    error('input dimensions do not agree');
end

B=A;    % initialize B to be A
for i=1:n;
    for j=1:i;
        B(i,j)=0;   % set B to be the strictly upper triangular part of A
    end
end

J=A-B;  % initialize J to be the lower triangular part of A.

y=-B*x0+b;  % calculate matrix vector product on right hand side
temp=Forward(J,y);  % solve the lower triangular system by forward
                        % substitution.
x1=w*temp+(1-w)*x0; % implement relaxation
k=1;    % Set iteration counter to 1

while (abs(x1-x0)>1e-12) & (k <= imax); % convergence if the approximations 
                                     % are close or the maximum number of
                                     % iterations is reached
    x0=x1;  
    y=-B*x0+b;      % calculate matrix vector product on right hand side
    temp=Forward(J,y);  % solve the lower triangular system by forward
                        % substitution.
    x1=w*temp+(1-w)*x0; % implement relaxation
    k=k+1;          % increment counter
end
x=x1;

[H,E]=iteration_analysis(J,B,w); % this function calculates the iteration  
                                 % matrix and its eigenvalues for 
                                 % illustrative purposes.
end

