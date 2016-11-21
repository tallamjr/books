function [ v,c,k ] = basic_power( A,tol )
% Implements basic power method to find an eigenvector of A, 
%   and its corresponding eigenvalue
% Input arguments:
%   A, square matrix
%   tol, tolerance; x is accepted as the eigenvector
%     with eigenvalue E if |Ax-Ex|<tol.
% Output arguments:
%   v, eigenvector of A
%   c, corresponding eigenvalue
%   k, number of iterations

[n,m]=size(A); % finding the size of A
if n~= m;
    error('input is not a square matrix');
elseif tol<=0;
    error('tolerance should be positive');
end

x0=rand(n,1);  % initializing x to a random vector
k=0;    % initializing k

while k>=0;     % this will always hold, another statement within the loop 
                % determines convergence and returns the function
                
    x1=A*x0;    % apply A to generate new estimate of eigenvector
    ray=x0'*A*x0/(x0'*x0);  % calculate Rayleigh quotient
    
    y=x1-ray*x0;    % we accept convergence if |y|<tol
    if sqrt(y'*y)<tol;  
        c=ray;      % accept Rayleigh quotient as eigenvalue
        v=x0;       % accept x0 as eigenvector
        return;     % return function
    else
        x0=x1/sqrt(x1'*x1); % normalize estimate of eigenvector
        k=k+1;              % increment k
    end
end

end


