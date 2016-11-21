% Usage example for midpoint_rule

a = -1;
b= 1;
for k = 0:5
    f = @(x) x^k;
    [ Q ] = midpoint_rule( f,a,b );
    disp(['Midpoint rule for x^', num2str(k), ' on [-1,1] is ', num2str(Q)]);
end
f = @sin;
[ Q ] = midpoint_rule( f,a,b );
disp(['Midpoint rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @cos;
[ Q ] = midpoint_rule( f,a,b );
disp(['Midpoint rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @exp;
[ Q ] = midpoint_rule( f,a,b );
disp(['Midpoint rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @(x) 1/x;
[ Q ] = midpoint_rule( f,a,b );
disp(['Midpoint rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @(x) 1/(1+x);
[ Q ] = midpoint_rule( f,a,b );
disp(['Midpoint rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
