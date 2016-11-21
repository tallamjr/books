function [ U, c , P ] = Gaussian_total( A,b )
% Performs Gaussian elimination with total pivoting on A to 
%   transform the system Ax=b to U(Px)=c.
%   Note the permutation matrix P stores the column swaps.
% Input arguments:
%   A, square matrix
%   b, column vector
% Output arguments:
%   U, square upper triangular matrix
%   c, column vector
%   P, square permutaion matrix

U=A; c=b;       % initialize U,c
[m,n]=size(A); % finding the size of A
P=eye(n);   % initialize permutation matrix to store column permutations
% check user inputs
if n~= m
    error('input is not a square matrix');
elseif size(b,1) ~= n
    error('input dimensions do not match');
end

for i=1:n;  % considering the rows in turn
    % choose the element with the greatest absolute value over the bottom
    % right (n-i)x(n-i) submatrix
    [c_value,c_ind]=max(abs(U(i:n,i:n))); 
    [~,r_ind]=max(abs(c_value));
    c_ind=c_ind(r_ind);
    r_ind=r_ind+i-1;
    c_ind=c_ind+i-1;  % index of largest element is (r_ind,c_ind)
    
    if abs(U(r_ind,c_ind))<1e-12;
        error('matrix is singular, there is no unique solution');
    else
        U([r_ind,i],:)=U([i,r_ind],:);  % interchange rows
        c([r_ind,i],1)=c([i,r_ind],1);  % perform same row swap on the
                                        % right hand side
    
        U(:,[c_ind,i])=U(:,[i,c_ind]);  % interchange columns 
        P(:,[c_ind,i])=P(:,[i,c_ind]);  % perform same column swap on P
    end
    
    for j=i+1:n;
        temp=(U(j,i)/U(i,i));       % eliminate elements below the diagonal 
        U(j,:)=U(j,:)-U(i,:)*temp;  % by subtracting a linear combination 
                                    % of rows
        
        c(j)=c(j)-c(i)*temp;        % perform the same row operation on the 
                                    % right hand side
    end
end

end

