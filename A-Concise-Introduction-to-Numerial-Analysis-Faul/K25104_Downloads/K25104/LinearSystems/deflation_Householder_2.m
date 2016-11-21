function [ D ] = deflation_Householder_2( A,v1,v2 )
% Given an nxn matrix A which has a 2-dimensional eigenspace 
%   spanned by v1 and v2, the function performs deflation creating 
%   an nxn matrix which is similar to A. That is it has the same 
%   eigenvalues as A. Householder reflections are used.
% Input arguments:
%   A, square matrix
%   v1,v2, two vectors which span a known eigenspace of A
% Output arguments:
%   D, deflated matrix. If A is symmetric, then D will also be symmetric

[n,m]=size(A);  % finding the size of A
[p,q]=size(v1); % finding the size of v1
[r,s]=size(v2); % finding the size of v2
if n~= m;
    error('input is not a square matrix');
elseif p~=n || q~=1 || r~=n || s~=1;
    error('input dimensions do not agree');
end

u1=v1;              % initializing u1 to v1
if v1(1)==0         % adjusting the first entry of u1
    u1(1)=u1(1)+sqrt(v1'*v1);
else
    u1(1)=u1(1)+sign(v1(1))*sqrt(v1'*v1);    
end
S1=eye(n)-2*(u1*u1')/(u1'*u1);  % assembling S1, a householder reflection 
                                % which maps the bottom n-1 elements of v1
                                % to zero

v_hat=S1*v2;        % initializing v_hat to S1*v2
v_hat=v_hat(2:n);   % letting v_hat be the lower n-1 entries of S1*v2
u2=v_hat;           % initializing u2 to v_hat
if v_hat(1) == 0    % adjusting the first entry of u2
    u2(1)=u2(1)+sqrt(v_hat'*v_hat);
else
    u2(1)=u2(1)+sign(v_hat(1))*sqrt(v_hat'*v_hat);  
end
S_hat=eye(n-1)-2*(u2*u2')/(u2'*u2); % assembing S_hat, a householder 
                    % reflection which maps the bottom n-2 elements of 
                    % v_hat to zero
                    
S2=eye(n);          % initializing S2 to the identity
S2(2:n,2:n)=S_hat;  % setting the bottom-right (n-1)x(n-1) submatrix of S2 
                    % to S_hat, so that S2*(S1*v2) is a linear combination
                    % of the first two standard basis vectors.
                    
D=S2*S1*A*S1*S2;    % generating deflated matrix

end

