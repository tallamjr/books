function [ v,c,k ] = inverse_iteration( A,s,tol )
% Implements inverse iteration to find an eigenvalue of A 
%   and its corresponding eigenvector
% Input arguments:
%   A, square matrix
%   s, estimate of eigenvalue
%   tol, tolerance
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

k=0;    % initializing k

while k>=0; 
    [L,U,P]=LU_pivot(A-s*eye(n));   % calculate the LU factorization 
                                    % with pivoting of (A-sI)
    d=diag(U);      
    if min(abs(d))<=1e-12;  % if any diagonal elements of U are close to zero
        c=s;                % accept s as the eigenvalue
        v=U;                % set output v to U
        disp(['eigenvalue found; v lies in the null space of '...
            'given matrix']);
        return;             % return function
    else
        if k==0;
            [~,i]=min(abs(d));      % i is the index of the smallest entry
                                    % along the diagonal of U
            ei=zeros(n,1); ei(i)=1; % initialize ith standard basis vector
            x0=L*ei;                % initialize x0
            x1=Backward(U,ei);     % calculate x1
            x1=P*x1; x0=P*x0;   % apply pivoting        
        else
            y=Forward(L,x0);      % calculate x1 from (A-sI)x1=x0
            x1=Backward(U,y);  
            x1=P*x1;            % apply pivoting
        end
        
        mu=x1'*(A-s*eye(n))*x1/(x1'*x1); % calculate mu which minimizes 
                                         % |x0-mu*x1|
        z=x0-mu*x1;            % if |z|<tol|x1| we terminate procedure 
        if sqrt(z'*z)<tol*sqrt(x1'*x1); 
            c=mu+s;            % accept mu+s as eigenvalue
            v=x1/sqrt(x1'*x1);  % normalize x1 and accept as eigenvector
            return;     % return function
        else
            x0=x1/sqrt(x1'*x1); % normalize x
            s=s+mu;     % adjust s
            k=k+1;      % increment k
        end
    end
end
end
            
            
        