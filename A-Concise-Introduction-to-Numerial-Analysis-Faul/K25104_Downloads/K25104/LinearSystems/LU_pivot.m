function [L,U,P]=LU_pivot(A)
% Computes the LU factorization with partial pivoting 
%   such that P * A = L * U
% Input arguments:
%   A, square matrix
% Output arguments:
%   L, square matrix of the same dimensions as A containing the lower
%     triangular portion of the LU factorization
%   U, square matrix of the same dimensions as A containing the upper
%     triangular portion of the LU factorization
%   P, square matrix of the same dimensions as A, a permutation matrix
%     representing row exchanges due to pivoting

[n,m]=size(A); % finding the size of A
if n~= m
    error('input is not a square matrix');
end
L=eye(n);   % initializing L to the identity matrix
P=L;        % initializing P to the identity matrix
U=A;        % initializing U to be A
for k=1:n   % loop calculates one column of L and one row of U at a time
    % Note that U holds in its lower portion a modified portion of A
    [~, m]=max(abs(U(k:n,k)));  % for the k-th column find the 
                                    % maximum element (in modulus)on or 
                                    % below the diagonal, its position
                                    % on or below the diagonal is
                                    % returned in m
    m=m+k-1; % calculate the row index of the maximum element by 
             % adding the (k-1) elements above the diagonal
    % if m = k, do nothing, because the maximum element is already on 
    % the diagonal
    if m~=k
        % swap rows m and k in U
        temp=U(k,:);    % temp holds the k-th row of U
        U(k,:)=U(m,:);  % assign the m-th row of U to the k-th row of U
        U(m,:)=temp;    % the m-th row of U becomes temp
        % swap rows m and k in P
        temp=P(k,:);
        P(k,:)=P(m,:);
        P(m,:)=temp;
        if k >= 2 % swap rows m and k in the portion of L already 
                  % calculated
            temp=L(k,1:k-1);
            L(k,1:k-1)=L(m,1:k-1);
            L(m,1:k-1)=temp;
        end
    end
    for j=k+1:n
        % if U(k,k) = 0, do nothing, because L is already initialised  
        % to the identity matrix and thus the k-th column is the k-th 
        % standard basis vector
        if abs(U(k,k)) > 1e-12  % not comparing to zero because of 
                                % possible rounding errors
        L(j,k)=U(j,k)/U(k,k);   % let L be the k-th column of the current 
                                % U scaled by the diagonal element
        end
        U(j,:)=U(j,:)-L(j,k)*U(k,:); % adust U by subtracting the outer 
                                     % product of of the k-th column of 
                                     % L and the k-th row of U
    end
end

