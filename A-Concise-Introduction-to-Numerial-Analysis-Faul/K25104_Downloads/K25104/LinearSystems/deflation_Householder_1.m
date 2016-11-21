function [ D ] = deflation_Householder_1( A,v )
% Given an nxn matrix and eigenvector, performs deflation 
%   creating an nxn matrix which is similar to A. That is it has the 
%   same eigenvalues as A. Householder reflections are used.
% Input arguments:
%   A, square matrix
%   v, eigenvector of A
% Output arguments:
%   D, deflated matrix. If A is symmetric then D will also be symmetric.

[n,m]=size(A); % finding the size of A
[p,q]=size(v); % finding the size of v
if n~= m;
    error('input is not a square matrix');
elseif q~=1 || p~=n;
    error('input dimensions do not agree');
end

u=v;                % initializing u to be v
if v(1) == 0        % adjusting the first entry of u
    u(1) = u(1)+sqrt(v'*v);
else
    u(1)=u(1)+sign(v(1))*sqrt(v'*v);    
end
H=eye(n)-2*(u*u')/(u'*u);   % creating householder transformation which 
                            % maps v to a multiple of the first standard 
                            % basis vector
D=H*A*H;                    % generating deflated matrix

end


