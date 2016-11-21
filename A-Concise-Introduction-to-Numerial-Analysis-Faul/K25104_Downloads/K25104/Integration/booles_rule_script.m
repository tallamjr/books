% Usage example for booles_rule

a = -1;
b= 1;
for k = 0:5
    f = @(x) x^k;
    [ Q ] = booles_rule( f,a,b );
    disp(['Boole',char(39),'s rule for x^', num2str(k), ' on [-1,1] is ', num2str(Q)]);
end
f = @sin;
[ Q ] = booles_rule( f,a,b );
disp(['Boole',char(39),'s rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @cos;
[ Q ] = booles_rule( f,a,b );
disp(['Boole',char(39),'s rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @exp;
[ Q ] = booles_rule( f,a,b );
disp(['Boole',char(39),'s rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @(x) 1/x;
[ Q ] = booles_rule( f,a,b );
disp(['Boole',char(39),'s rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @(x) 1/(1+x);
[ Q ] = booles_rule( f,a,b );
disp(['Boole',char(39),'s rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
