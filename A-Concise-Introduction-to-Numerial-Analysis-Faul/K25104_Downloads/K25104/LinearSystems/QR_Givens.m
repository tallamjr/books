function [ Q,R ] = QR_Givens( A )
% Computes the QR factorization of A via Givens rotations
% Input arguments:
%   A, matrix
% Output arguments:
%   Q, square orthogonal matrix
%   R, upper triangular

[n,~]=size(A);  % finding the size of A

R=A; Q=eye(n);  % initializing matrices Q,R

for j=1:n-1;
    for i=j+1:n;
        if R(i,j)~=0;   % if the element is non-zero
            [R,G]=Givens(R,i,j);    % call function which introduces a 
                % zero in the (i,j)th entry of R using a Givens rotation.
            Q=Q*G';     % keep track of Q
        end
    end
end

end

