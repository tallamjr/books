function [ x,k ] = conjugate_gradient( A,b,tol )
% Implements method of conjugate gradients 
%   to find the solution of the system Ax=b.
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

x=zeros(n,1);   % initialize x
r0=b;d=b;       % initialize r0 and d to b
k=0;            % initialize counter

if sqrt(r0'*r0)<tol; % if this is true then the zero vector is the solution
    return;
else                 % implement first step
    v=A*d;           % calculate this matrix-vector product, which will 
                     % be needed twice more
    w=r0'*r0/(d'*v); % calculate step size in the descent direction
    x=x+w*d;         % update x
    r1=r0-w*v;       % update the residual
    k=k+1;           % increment counter
end

while sqrt(r1'*r1)>tol; % repeat the following until convergence
    B=r1'*r1/(r0'*r0);  % this choice of B ensures the search directions 
                        % are conjugate with respect to A. 
    d=r1+B*d;           % update the search direction
    r0=r1;              % update r0
    v=A*d;              % calculate this matrix-vector product, which will 
                        % be needed twice more
    w=r0'*r0/(d'*v);    % calculate step size in the descent direction
    x=x+w*d;            % update x
    r1=r0-w*v;          % update r1
    k=k+1;              % increment counter
end

end
    
