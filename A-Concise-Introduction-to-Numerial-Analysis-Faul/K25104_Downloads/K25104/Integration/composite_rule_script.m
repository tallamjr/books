% Usage example for composite_rule

a = -1;
b= 1;
n = 10;
m = 5;
rule = 'gauss_legendre';
for k = 0:5
    f = @(x) x^k;
    [ Q ] = composite_rule( f,a,b,n,m,rule );
    disp(['Gauss-Legendre composite',' rule for x^', num2str(k), ' on [-1,1] is ', num2str(Q)]);
end
f = @sin;
[ Q ] = composite_rule( f,a,b,n,m,rule );
disp(['Gauss-Legendre composite',' rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @cos;
[ Q ] = composite_rule( f,a,b,n,m,rule );
disp(['Gauss-Legendre composite',' rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @exp;
[ Q ] = composite_rule( f,a,b,n,m,rule );
disp(['Gauss-Legendre composite',' rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @(x) 1/x;
[ Q ] = composite_rule( f,a,b,n,m,rule );
disp(['Gauss-Legendre composite',' rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @(x) 1/(1+x);
[ Q ] = composite_rule( f,a,b,n,m,rule );
disp(['Gauss-Legendre composite',' rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
