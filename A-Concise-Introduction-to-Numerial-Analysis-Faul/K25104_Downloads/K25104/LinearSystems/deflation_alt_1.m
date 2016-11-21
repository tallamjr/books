function [ D ] = deflation_alt_1( A,v )
% Given an nxn matrix and eigenvector, performs deflation 
%   creating an nxn matrix which is similar to A. That is it has the 
%   same eigenvalues as A. Uses an alternative algorithm.
% Input arguments:
%   A, square matrix
%   v, eigenvector of A
% Output arguments:
%   D, deflated matrix

[n,m]=size(A); % finding the size of A
[p,q]=size(v); % finding the size of v
if n~= m;
    error('input is not a square matrix');
elseif q~=1 || p~=n;
    error('input dimensions do not agree');
end

% find index of first nonzero entry in v
k=1;
while v(k)==0
    k=k+1;
end
if k>n
    error('zero vector is invalid input');
end

if k>1
    P=eye(n);   % generate permutation matrix such that 
    P(1,1)=0;   % first entry in P*v is non-zero
    P(1,k)=1;
    P(k,1)=1;
    P(k,k)=0;
    v = P*v;
    A = P*A*P'; % adjust A
end
S=eye(n);   % initializing S to the identity
for i=2:n;  % adjusting S so that the bottom n-1 entries of S*v are zero
    S(i,1)=-v(i)/v(1);
end

S_inv=2*eye(n)-S;   % calculating inverse of S

D=S*A*S_inv;        % generating deflated matrix

end

