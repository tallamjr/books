function [ D ] = deflation_alt_2( A,v1,v2 )
% Given an nxn matrix A which has a 2-dimensional eigenspace 
%   spanned by v1 and v2, the function performs deflation creating 
%   an nxn matrix which is similar to A. That is it has the same 
%   eigenvalues as A. Uses an alternative algorithm.
% Input arguments:
%   A, square matrix
%   v1,v2, two vectors which span a known eigenspace of A
% Output arguments:
%   D, deflated matrix

[n,m]=size(A);      % finding the size of A
[p,q]=size(v1);     % finding the size of v1
[r,s]=size(v2);     % finding the size of v2
if n~= m;
    error('input is not a square matrix');
elseif p~=n || q~=1 || r~=n || s~=1;
    error('input dimensions do not agree');
end

% find index of first nonzero entry in v1
k1=1;
while v1(k1)==0
    k1=k1+1;
end
if k1>n
    error('zero vector is invalid input');
end

% find index of first nonzero entry in v2
k2=1;
while v2(k2)==0
    k2=k2+1;
end
if k2>n
    error('zero vector is invalid input');
end

if k1>1
    if k2>1         % first entry in v1 and v2 is zero
        P=eye(n);   % generate permutation matrix such that 
    	P(1,1)=0;   % first entry in P*v1 is non-zero
    	P(1,k1)=1;
        P(k1,1)=1;
        P(k1,k1)=0;
        v1 = P*v1;
        v2 = P*v2;
        A = P*A*P'; % adjust A
    else            % first entry of v2 is non-zero, swap v1 and v2
        temp = v1;
        v1 = v2;
        v2 = temp;
    end
end

S1=eye(n);  % initializing S1, to the nxn identity
for i=2:n;                 
    S1(i,1)=-v1(i)/v1(1);   % adjusting S1 so that the bottom n-1 entries 
                            % of S1*v1 are zero
end
S1_inv=2*eye(n)-S1; % calculating the inverse of S1
D = S1*A*S1_inv;

v_hat=S1*v2;        % initializing v_hat to S1*v2
% find index >= 2 of first nonzero entry in v_hat
k=2;
while v_hat(k)==0
    k=k+1;
end
if k>n
    error('zero vector is invalid input');
end
if k>2
    P=eye(n);   % generate permutation matrix such that 
    P(2,2)=0;   % first entry in P*v is non-zero
    P(2,k)=1;
    P(k,2)=1;
    P(k,k)=0;
    v_hat = P*v_hat;
    D = P*D*P'; % adjust D
end
S_hat=eye(n-1); % initializing S_hat to the (n-1)x(n-1) identity
v_hat=v_hat(2:n);   % letting v_hat be the lower n-1 entries of S1*v2
for i=2:n-1;                                                         
    S_hat(i,1)=-v_hat(i)/v_hat(1);  % adjusting S_hat such that the bottom
                                    % n-2 entries of S_hat*v_hat are zero
end
S_hat_inv=2*eye(n-1)-S_hat; % calculating inverse of S_hat

S2=eye(n);S2_inv=eye(n);    % initializing S2, S2_inv to the nxn identity

S2(2:n,2:n)=S_hat;  % setting the bottom-right (n-1)x(n-1) submatrix of S2 
                    % to S_hat, so that S2*(S1*v2) is a linear combination
                    % of the first two standard basis vectors.
                    
S2_inv(2:n,2:n)=S_hat_inv;  % calculating inverse of S2

D=S2*D*S2_inv;    % generating deflated matrix

end

