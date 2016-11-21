function [ D,k ] = QRalg_Householder( A,tol )
% Performs QR algorithm to deflate matrix A, 
%   QR factorization is performed with Householder Reflections
% Input arguments:
%   A, square matrix
%   tol, tolerance
% Output arguments:
%   D, deflated matrix
%   k, number of iterations

[n,m]=size(A);  % finding the size of A
if n~= m;
    error('input is not a square matrix');
end

U=A; % initialize U to be A
[Q,R]=QR_Householder_2(U); % this function computes the QR factorization 
                    % of U using Householder reflections
U=R*Q; % compute R*Q
% check whether an entry on the first subdiagonal is close to zero
[m,i] = min(abs(diag(U,-1))); 
if m<tol    % check whether the (n-i)x(i) bottom left block is 
            % close to zero
    m = min(U(i+1:n,1:i));
end
k=1; % initialize counter

while m>tol;
    [Q,R]=QR_Householder_2(U); % this function computes the QR factorization 
                        % of A using Householder reflections
    U=R*Q; % compute R*Q
    % check whether an entry on the first subdiagonal is close to zero
    [m,i] = min(abs(diag(U,-1))); 
    if m<tol    % check whether the (n-i)x(i) bottom left block is 
                % close to zero
        m = min(U(i+1:n,1:i));
    end
k=k+1; % increment counter
end
D=U; % output deflated matrix
end
