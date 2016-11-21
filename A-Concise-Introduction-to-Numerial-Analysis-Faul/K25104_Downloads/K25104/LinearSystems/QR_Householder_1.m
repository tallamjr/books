function [ Q,R ] = QR_Householder_1( A )
% Computes the QR factorization of A via Householder reflections
% explicitly calculating the matrix of the Householder reflection
% Input arguments:
%   A, matrix
% Output arguments:
%   Q, square orthogonal matrix
%   R, upper triangular

[n,m]=size(A);  % finding the size of A

R=A; Q=eye(n);  % initialize Q and R

% considering the columns in turn
for j=1:min(n,m);
    u=R(:,j);           % initialize vector u to be jth column 
    for i=1:j-1;        % set first j-1 entries of u to zero
        u(i)=0;
    end
    if u(j) == 0
       u(j) = u(j)+norm(u);
    else
       u(j)=u(j)+sign(u(j))*norm(u); % set jth entry of u avoiding 
                                     % loss of significance 
    end
    if norm(u) == 0
            H=eye(n);
    else
            H=eye(n)-(2/norm(u)^2)*(u*u') ; % form Householder reflection
    end
    R=H*R;      % apply reflection
    Q=Q*H';     % update Q by right multiplying by H transpose
end
end


