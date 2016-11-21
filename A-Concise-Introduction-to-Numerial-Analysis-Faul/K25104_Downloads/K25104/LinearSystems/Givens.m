function [ B,G ] = Givens( A,i,j )
% Applies one Givens rotation to place a zero in the (i,j)th entry of A.
% Input arguments:
%   A, matrix
%   i, row index
%   j, column index, j<i
% Output arguments:
%   G, Givens rotation
%   B, B = G*A

[n,~]=size(A); % finding the size of A
if i>n || j>n || j>=i;   % Check that the indices specify an element of A
    error('element specified by the indices is not below the diagonal');
end

G=eye(n); B=A; % initializing G to the identity and B to A

if abs(A(i,j))>0    % only apply Givens rotation if A(i,j) is non-zero
                    % otherwise no action necessary
    s=A(i,j)/sqrt(A(i,j)^2 + A(j,j)^2); % calculating the sine and cosine
    c=A(j,j)/sqrt(A(i,j)^2 + A(j,j)^2);  
    G(i,i)=c; G(j,j)=c;     % creating the relevant Givens rotation
    G(i,j)=-s; G(j,i)=s;
    B=G*B;      % applying the Givens rotation
end

end

