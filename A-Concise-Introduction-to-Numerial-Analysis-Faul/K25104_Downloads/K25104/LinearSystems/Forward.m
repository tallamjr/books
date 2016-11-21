function [x] = Forward(A,b)
% Solves the lower triangular system of equations Ax = b
% Input arguments:
%   A, square lower triangular matrix
%   b, Ax = b
% Output argument:
%   x solution

[n,m]=size(A); % finding the size of A
if n~= m
    error('input is not a square matrix');
end
if size(b,1) ~= n
    error('input dimensions do not match');
end
if ~istril(A)
    error('matrix is not lower triangular')
end

x = zeros(n,1); % initialize x to the same dimension
if abs(A(1,1)) > 1e-12 % not comparing to zero because of possible
                       % rounding errors
    x(1) = b(1)/A(1,1); % solve for the first element of x
else
    disp('input singular'); % A is singular if any of the diagonal 
                            % elements are zero
    return;
end
for k=2:n % the loop considers one row after the other
    if abs(A(k,k))>1e-12 % not comparing to zero because of possible
                         % rounding errors
        temp = 0;
        for j=1:k-1
            temp = temp + A(k,j) * x(j); % Multiply the elements of 
                                     % the k-th row of A before the 
                                     % diagonal by the elements of x 
                                     % already calculated
        end
        x(k) = (b(k)-temp)/A(k,k); % solve for the k-th element of x
    else
        disp('input singular'); % A is singular if any of the 
                                % diagonal elements are zero
        return;
    end
end