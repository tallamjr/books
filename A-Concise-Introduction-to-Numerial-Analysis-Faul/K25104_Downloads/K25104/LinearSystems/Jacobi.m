function [ x,k,H,E ] = Jacobi( A,b,x0,w,imax )
% Solves the linear system Ax=b iteratively by Jacobi method.
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
if n~= m
    error('input is not a square matrix');
elseif size(b,1)~=m;  % check length of b
    error('input dimensions do not agree');
end

J=diag(diag(A));    % Set J to be the diagonal part of A
B=A-J;  % Set B to be the off-diagonal part of A
temp=-B*x0+b;  % calculate matrix vector product on right hand side
for i=1:m;  % solve diagonal system
    temp(i)=temp(i)/J(i,i);
end
x1=w*temp+(1-w)*x0; % implement relaxation
k=1;    % Set iteration counter to 1

while (abs(x1-x0)>1e-12) & (k <= imax); % convergence if the approximations 
                                     % are close or the maximum number of
                                     % iterations is reached
    x0=x1;  
    temp=-B*x0+b;  % calculate matrix vector product on right hand side
    for i=1:m;  % solve diagonal system
        temp(i,1)=temp(i)/J(i,i);
    end
    x1=w*temp+(1-w)*x0; % implement relaxation
    k=k+1;  % increment counter
end
x=x1;

[H,E]=iteration_analysis(J,B,w); % this function calculates the iteration  
                                 % matrix and its eigenvalues for 
                                 % illustrative purposes.              
end

