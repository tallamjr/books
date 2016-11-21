function [ x ] = Householder( v,k )
% Introduces zeros to the column vector v below the kth element 
%   using a Householder reflection
% Input arguments:
%   v, colummn vector
%   k, index
% Output arguments:
%   x, transformed vector

[n,m]=size(v);  % check the size of v
if m~=1;
    error('input is not a column vector');
elseif k>n || k<1;     % check that k is a valid index of v
    error('input is not a valid index');
end

u=v;            % initialize vector u to be v
for i=1:k-1;    % set first k-1 entries of u to zero
    u(i)=0;
end
if u(k) == 0
    u(k) = u(k)+norm(u);
else
    u(k)=u(k)+sign(u(k))*norm(u); % set kth entry of u avoiding loss of 
                                  % significance 
end
if norm(u) == 0
    x = v;
else
    y=u'*v;                 % form vector product
    x=v-(2/norm(u)^2)*u*y;  % form x
end

end

