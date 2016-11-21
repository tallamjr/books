% Usage example for transformed_preconditioned_CG

A = [3 1 0 0;
    1 4 1 3;
    0 1 10 0;
    0 3 0 3];
b = [1;
    1;
    1;
    1];
% the preconditioner is chosen such that P*P' is the inverse of the
% diagonal of A
P = sqrt(inv(diag(diag(A))));
tol = 1e-6;

[ x,k ] = transformed_preconditioned_CG(A,b,P,tol )
