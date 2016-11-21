function [ U,c ] = Gaussian_partial( A,b )
% Performs Gaussian elimination with partial pivoting on A 
%   to transform the system Ax=b to Ux=c, where U is upper triangular.
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
    error('input dimensions do not match');
end

for i=1:n;
    [~,index]=max(abs(U(i:n,i))); % choose the element with the  
                            % greatest absolute value from those below the
                            % diagonal in the ith column
    index=index+i-1;    
    
    largest=max(abs(U(index,:)));   % check comparative size of pivot 
    if abs(U(index,i)/largest)<1e-12;   % element to others in its row
        error(['pivot element is comparatively small, '...
             'alternative pivoting strategy required']);
    else
        P=eye(n);       % create permutation matrix to interchange rows
        P(:,[index,i])=P(:,[i,index]);
        
        U=P*U; c=P*c;   % apply permutation to both sides 
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
