function [ R ] = RK_stab_fun( b,c,A )
% derives the stability function for the Runge-Kutta method prescribed by b,c,A
% Input arguments:
%   b, column vector holding the Runge-Kutta weights
%   c, column vector holding the Runge-Kutta nodes
%   A, matrix holding the coefficients a(i,j) which prescribe the method.
% Output arguments:
%   R stability function

% first check user inputs
[Arows,Acols]=size(A);
[brows,bcols]=size(b);
[crows,ccols]=size(c);
if Arows~=Acols;    
    error('matrix must be a square matrix');
elseif bcols~=1 || ccols~=1;
    error('input must be column vectors');
elseif brows~=Arows || crows~=Arows;
    error('dimensions do not match');
end

syms z      % create symbolic variable
R=1+z*b'*inv(eye(Acols)-z*A)*ones(Acols,1); % construct stability function
end

