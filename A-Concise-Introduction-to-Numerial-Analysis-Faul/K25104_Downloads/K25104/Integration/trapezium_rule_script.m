% Usage example for trapezium_rule

a = -1;
b= 1;
for k = 0:5
    f = @(x) x^k;
    [ Q ] = trapezium_rule( f,a,b );
    disp(['Trapezium rule for x^', num2str(k), ' on [-1,1] is ', num2str(Q)]);
end
f = @sin;
[ Q ] = trapezium_rule( f,a,b );
disp(['Trapezium rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @cos;
[ Q ] = trapezium_rule( f,a,b );
disp(['Trapezium rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @exp;
[ Q ] = trapezium_rule( f,a,b );
disp(['Trapezium rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @(x) 1/x;
[ Q ] = trapezium_rule( f,a,b );
disp(['Trapezium rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @(x) 1/(1+x);
[ Q ] = trapezium_rule( f,a,b );
disp(['Trapezium rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
