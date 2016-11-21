function [ Q,R ] = QR_Givens_zeros( A,v )
% Computes the QR factorization of A via Givens rotations
%   using knowledge about leading zeros
% Input arguments:
%   A, matrix
%   v, vector giving number of leading zeros in each row of A
% Output arguments:
%   Q, square orthogonal matrix
%   R, upper triangular

[n,~]=size(A);  % finding the size of A

if size(v,1)~=n;
    error('dimensions of vector are not consistent');
end

R=A; Q=eye(n);  % initializing matrices

for i=2:n;              % considering the rows in turn
    for j=v(i)+1:i-1    % ignore the first v(i) entries in the row, since
                        % we know they are all zero
        if R(i,j)~=0;   % if the element is non-zero
            [R,G]=Givens(R,i,j);    % call function which introduces a 
                % zero in the (i,j)th entry of R using a Givens rotation.
            Q=Q*G';     % keep track of Q
        end
    end
end
