% Usage example for gauss_legendre_rule
% related to Exercies 5.3

a = -1;
b= 1;
E = zeros(10,4);
for n=2:5
    for j = 1:10
        syms x;
        f = x^j;
        I = int(f,x,a,b); % true value of the integral
        f = matlabFunction(f);
        [ Q ] = gauss_legendre_rule( f,a,b,n ); % approximation of the integral
        E(j,n-1) = Q-I;
    end
end
disp('The difference between the Gauss-Legendre rule (n=2,3,4,5) and the true value integrating x^j, j=1,...10 is');
format shortE;
E