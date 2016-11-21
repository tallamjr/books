function [ Q,R ] = QR_Householder_2( A )
% Computes the QR factorization of A via Householder reflections
% avoids calculating the matrix of the Householdre reflection
% Input arguments:
%   A, matrix
% Output arguments:
%   Q, square orthogonal matrix
%   R, upper triangular

[n,m]=size(A);  % finding the size of A

R=A; Q=eye(n);  % initialize Q and R

% considering the columns in turn
for j=1:min(n,m);
    u=R(:,j);           % initialize vector u to be jth column 
    for i=1:j-1;        % set first j-1 entries of u to zero
        u(i)=0;
    end
    if u(j) == 0
       u(j) = u(j)+norm(u);
    else
       u(j)=u(j)+sign(u(j))*norm(u); % set jth entry of u avoiding 
                                          % loss of significance 
    end
    if norm(u) ~= 0
       y=u'*R;                 % form matrix-vector product
       R=R-(2/norm(u)^2)*u*y;  % form R
                        
       z=u'*Q;                 % perform same operation on Q
       Q=Q-(2/norm(u)^2)*u*z;
    end
end
Q=Q';   % reassign Q to its transpose           
end