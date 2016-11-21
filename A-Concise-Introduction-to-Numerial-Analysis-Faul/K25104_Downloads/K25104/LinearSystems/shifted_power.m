function [ v,c,k ] = shifted_power( A,s,tol )
% Implements power method with shifts to find an eigenvector of A,
%   and its corresponding eigenvalue.
% Input arguments:
%   A, square matrix
%   s, scalar shift
%   tol, tolerance
% Output arguments:
%   v, eigenvector of A
%   c, corresponding eigenvalue
%   k, number of iterations

[n,m]=size(A); % finding the size of A
if n~= m;
    error('input A is not a square matrix');
elseif tol<=0;
    error('tolerance should be positive');
end

x0=rand(n,1);  % initializing x to a random vector
k=0;    % initializing k

while k>=0; 
    B = (A-s*eye(n));
    x1=B*x0; % apply (A-sI) to generate new estimate 
                        % of eigenvector
    rayleigh=x0'*B*x0/(x0'*x0);  % calculate Rayleigh coefficient
    
    y=x1-rayleigh*x0;   % if |y|<tol we terminate procedure 
    if sqrt(y'*y)<tol;  
        c=rayleigh+s;   % accept rayleigh+s as eigenvalue
        v=x0;           % accept x0 as eigenvector
        return;         % return function
    else
        x0=x1/sqrt(x1'*x1); % normalize x
        k=k+1;              % increment k
    end
end


end

