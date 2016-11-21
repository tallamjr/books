function [ v1,c1,v2,c2,r1,r2,k ] = twostage_power( A,x0,tol )
% Implements 2-stage power method to find a complex conjugate pair 
%   of eigenvalues for A, and their corresponding eigenvectors.
% Input arguments:
%   A, square matrix
%   x0, starting vector
%   tol, tolerance
% Output arguments:
%   v1,v2, eigenvectors of A
%   c1,c2, corresponding eigenvalues
%   r1,r2, real vectors which span the eigenspace 
%   k, number of iterations

[n,m]=size(A); % finding the size of A
if n~= m;
    error('input A is not a square matrix');
elseif tol<=0;
    error('tolerance should be positive');
end

x1=A*x0;    % initialize x1
k=0;        % initialize k to zero
while k>=0;     % this will always hold, another statement within the loop 
                % determines convergence and returns the function
                
    x2=A*x1;    % calculate x2
    
    % calculate a and b which minimize the norm of x2+a*x1+b*x0
    denom=((x0'*x0)*(x1'*x1)-(x1'*x0)^2);   
    a=(x1'*x0)*(x2'*x0)-(x0'*x0)*(x2'*x1);  
    a=a/denom;
    b=(x1'*x0)*(x2'*x1)-(x1'*x1)*(x2'*x0);
    b=b/denom;
    
    y=x2+a*x1+b*x0;  
    if norm(y)<tol;         % if |y|<tol we terminate procedure
        p=[1,a,b];          % then we solve the polynomial with these
        q=roots(p);         % coefficients
        
        c1=q(1); c2=q(2);   % take roots the polynomial to be the required 
                            % eigenvalues
                            
        v1=x1-c2*x0;        % generate the corresponding eigenvectors
        v2=x1-c1*x0;
        
        r1=real(v1);        % let r1 and r2 be the real and imaginary parts 
        r2=imag(v1);        % of the eigenvectors, then they are real 
                            % vectors which span the same eigenspace as 
                            % v1 and v2.
        return;             % return the function
    else
        x0=x1/norm(x1);     % adjust x0 and normalize
        x1=x2/norm(x1);     % adjust x1
        k=k+1;              % increment k
    end
end
end


    

