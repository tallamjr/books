function [res, abserr, relerr, n]= sinbysum(x, e)
% Approximates sin(x) by its expansion
% x input argument
% e input argument for the stopping criterion
% res final approximation
% abserr final absolute error
% relerr final relative error
% n number of iterations needed to reach the stopping criterion

res = x; % initialize the result, for small values of x sin(x) is 
         % approximately x
d = abs(x); % d holds by how much the approximation has changed in 
            % one iteration in modulus
n = 1; % the iteration count is initialised to 1 since res =  x is 
       % the first approximation
while d > e
    n = n+1;
    m = 2*n-1;
    temp = x^(m)/factorial(m); % element of the sum to be subtracted 
                               % or added
    d = abs(temp);
    if mod(n,2) == 0 % even iteration number, we have to subtract
        res = res - temp;
    else % odd iteration number, we have to add
        res = res + temp;
    end
end
truesol = sin(x);
abserr = res - truesol;
if abs(truesol) > 1e-12 % not comparing to zero because of possible
                        % rounding errors
    relerr = abserr/truesol;
else
    disp('relative error not computed, the solution is too small');
end