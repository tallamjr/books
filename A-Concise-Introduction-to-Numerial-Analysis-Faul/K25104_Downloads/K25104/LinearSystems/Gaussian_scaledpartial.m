function [ U,c ] = Gaussian_scaledpartial( A,b )
% Performs Gaussian elimination with scaled partial pivoting on A 
%   to transform the system Ax=b to Ux=c, where U is upper triangular.
% Input arguments:
%   A, square matrix
%   b, column vector
% Output arguments:
%   U, square, upper triangular matrix
%   c, column vector

U=A; c=b;       % initialize U,c
% check user inputs
[m,n]=size(A); % finding the size of A
if n~= m
    error('input is not a square matrix');
elseif size(b,1) ~= n
    error('input dimensions do not match');
end

for i=1:n;      % considering the rows in turn
    temp1 = U(i:n,i);
    for k=i:n;
        temp2 = max(abs(U(k,:))); % greatest absolute value in each row
        if temp2 > 1e-12;   % otherwise entire row close to zero
            temp1(k-i+1) = temp1(k-i+1)/temp2;
        end
    end
    
    % element with the largest scaled value is chosen as pivot.
    [~,index]=max(abs(temp1)); 
    % adjust the index to make it relative to the whole matrix
    index=index+i-1;       
    
    P=eye(n);       % create permutation matrix to interchange rows
    P(:,[index,i])=P(:,[i,index]);
    U=P*U; c=P*c;   % apply permutation to both sides 
        
    for j=i+1:n;
        temp=(U(j,i)/U(i,i));       % eliminate elements below the diagonal 
        U(j,:)=U(j,:)-U(i,:)*temp;  % by subtracting a linear combination 
                                    % of rows
                                    
        c(j)=c(j)-c(i)*temp;        % perform the same row operation on the 
                                    % right hand side
    end
end 

end

