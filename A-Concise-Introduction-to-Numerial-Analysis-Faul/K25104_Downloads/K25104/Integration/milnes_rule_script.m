% Usage example for milnes_rule

a = -1;
b= 1;
for k = 0:5
    f = @(x) x^k;
    [ Q ] = milnes_rule( f,a,b );
    disp(['Milne',char(39),'s rule for x^', num2str(k), ' on [-1,1] is ', num2str(Q)]);
end
f = @sin;
[ Q ] = milnes_rule( f,a,b );
disp(['Milne',char(39),'s rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @cos;
[ Q ] = milnes_rule( f,a,b );
disp(['Milne',char(39),'s rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @exp;
[ Q ] = milnes_rule( f,a,b );
disp(['Milne',char(39),'s rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @(x) 1/x;
[ Q ] = milnes_rule( f,a,b );
disp(['Milne',char(39),'s rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
f = @(x) 1/(1+x);
[ Q ] = milnes_rule( f,a,b );
disp(['Milne',char(39),'s 3/8 rule for ', func2str(f), ' on [-1,1] is ', num2str(Q)]);
