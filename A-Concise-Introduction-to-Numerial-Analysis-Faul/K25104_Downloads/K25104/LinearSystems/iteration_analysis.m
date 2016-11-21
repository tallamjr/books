function [ H,E ] = iteration_analysis( C,B,w )
% Calculates the iteration matrix and its eigenvalues 
%   arising from solving the system Ax = b iteratively 
%   by splitting A=B+C and Cx=-Bx+b.
% Input arguments:
%   C, square matrix
%   B, square matrix
%   w, relaxation parameter (w=1 gives unrelaxed iterations)
% Output arguments:
%   H, iteration matrix 
%   E, eigenvalues of the iteration matrix

[m,n]=size(C); % find the size of C
if n~= m
    error('first input is not a square matrix');
end;
[k,l]=size(B); % find the size of B
if k~= l
    error('second input is not a square matrix');
end;
if m~=k
    error('matrix dimensions do not agree');
end;
    
H=(1-w)*eye(n)-w*inv(C)*B;
E=eig(H);

end


