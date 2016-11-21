function [ Q,R ] = Gram_Schmidt( A )
% Computes the QR factorization of A via the Gram-Schmidt process
% Input arguments:
%   A, matrix
% Output arguments:
%   Q, orthogonal matrix
%   R, upper triangular matrix

[n,m]=size(A);  % finding the size of A
Q = zeros(n,n); % preallocating matrices R and Q
R = zeros(n,m);

k=0;    % initializing k to zero
for j=1:m
    if k==0;
        w=A(:,j);   % initially take w to be the first column of A
    else
        w=A(:,j);
        for i=1:k;
            % by this construction w is orthogonal to first k columns of Q
            w=w-(Q(:,i)'*A(:,j))*Q(:,i); 
        end
    end                          
    
    % if |w| is zero then no new column of Q is constructed
    if abs(w)<1e-12;
        if abs(A(:,j))<1e-12;
            R(:,j)=0;
        else
            for i=1:k;
                R(i,j)=(Q(:,i)'*A(:,j));
            end
            for i=k+1:n;
                R(i,j)=0;
            end
        end
    else
        k=k+1;  % increment k
        Q(:,k)=w/sqrt(w'*w);   
        for i=1:k-1;
            R(i,j)=(Q(:,i)'*A(:,j));
        end
        R(k,j)=sqrt(w'*w);
        for i=k+1:n;
            R(i,j)=0;
        end
    end
end

% if k<n then we need to construct more columns for Q
if k<n;         
    for i=k+1:n;
        % Find row of Q where the row sum is less than 1
        S = sum(Q,2);
        j=1;
        while S(j) >= 1
            j=j+1;
        end
        % construct new column from j-th standard unit vector
        x=zeros(n,1);
        x(j) = 1;
        for j=1:i;
            x=x-(x'*Q(:,j))*Q(:,j);
        end
        x=x/sqrt(x'*x); % normalize
        Q(:,i)=x;
    end
end

end
        


    
    
            

