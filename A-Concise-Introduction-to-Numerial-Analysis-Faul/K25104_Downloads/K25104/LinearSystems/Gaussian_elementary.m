function [U,c] = Gaussian_elementary(A,b)
% Performs elementary Gaussian elimination (no pivoting) on A 
%   to transform the system Ax=b to Ux=c, where U is upper triangular.
%   A warning is given if a diagonal element is close to zero.
% Input arguments:
%   A, square matrix
%   b, vector
% Output arguments:
%   U, upper triangular matrix
%   c, vector

U=A; c=b;   % initialize U,c
[m,n]=size(A); % finding the size of A
if n~= m
    error('input is not a square matrix');
elseif size(b,1) ~= n
    error('input dimensions do not agree');
end

for i=1:n;
    if abs(U(i,i))< 1e-12;
        error('diagonal element is close to zero, pivoting strategy required');
    end
    for j=i+1:n;
        if abs(U(j,i)) < 1e-12;
            U(j,i) = 0;                 % if U(j,i) is close to zero, treat as zero
        else
            temp=(U(j,i)/U(i,i));       % eliminate elements below the diagonal by 
            U(j,:)=U(j,:)-U(i,:)*temp;  % subtracting a linear combination of rows
                                     
            c(j)=c(j)-c(i)*temp;        % perform the same row operation on the 
                                        % right hand side
        end
    end
end 

end

