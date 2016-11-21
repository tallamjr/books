function [ Q ] = Cholesky( A )
% Computes the Cholesky factorization of A
% Input arguments:
%   A, symmetric positive definite matrix
% Output arguments:
%   Q, square matrix of the same dimensions as A such that A=Q*Q'

[n,m]=size(A); % finding the size of A
if n~=m;
    error('input is not a square matrix');
end

L=eye(n); D=eye(n); Q=eye(n); % initializing L,D,Q to the identity matrix
U=A;                % initializing U to be A
for i=1:n;          % first generate the LDL' factorization of A
    D(i,i)=U(i,i);
    if D(i,i)==0;   % if any element of D is zero then A is singular
        error('Matrix is singular');
    end
    L(:,i)=U(:,i)/U(i,i);
    if D(i,i)<0;    % if any element of D is negative then A is not
                    % positive definite
        error('Matrix is not positive definite');
    end
    U=U-D(i,i)*L(:,i)*L(:,i)';
end

D=D.^(1/2); % '.^' performs element-wise exponentiation
Q=L*D;

end
