function [L,U] = LU_banded( A,band )
% Computes the LU factorization on banded matrix A
% Input arguments:
%   A, square banded matrix
%   band, number of sub and super diagonals which are non-zero
% Output arguments:
%   L, square matrix of the same dimensions as A containing the lower
%     triangular portion of the LU factorization
%   U, square matrix of the same dimensions as A containing the upper
%     triangular portion of the LU factorization

% check user inputs
[m,n]=size(A);  % find the size of A
if n~=m
    error('input is not a square matrix');
end
if ~isbanded(A,band,band)
    error('matrix is not banded')
end
b=band;
if b>n-1
    b=n-1;
end
 
L=eye(n); % initializing L to the identity matrix
U=A; % initializing U to be A
for k=1:n % loop calculates one column of L and one row of U at a time
    % Note that U holds in its lower portion a modified portion of A
    for j=k+1:min([k+b,n])
        % if U(k,k) = 0, do nothing, because L is already initialized
        % to the identity matrix and thus the k-th column is the k-th
        % standard basis vector
        if abs(U(k,k)) > 1e-12 % not comparing to zero because of 
                               % possible rounding errors
        L(j,k)=U(j,k)/U(k,k); % let the k-th column of L be the k-th 
                              % column of the current U scaled by 
                              % the diagonal element
        end
        U(j,:)=U(j,:)-L(j,k)*U(k,:); % adjust U by subtracting the 
                                     % outer product of of the k-th 
                                     % column of L and the k-th row 
                                     % of U
    end

end