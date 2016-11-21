function [ Q ] = trapezium_rule( f,a,b )
% Employs the trapezium rule to integrate f between a and b
% Input arguments
%   f, function handle
%   a,b, integration bounds, a<b
% Output arguments:
%   Q, value of integral 

% first check user inputs
if isa(f,'function_handle')==0;
    error('input must be a function handle');
elseif a>=b;
    error('invalid interval');
end

fa=feval(f,a);  % evaluate f(a)
fb=feval(f,b);  % evaluate f(b)

Q=(b-a)*(fa+fb)/2;   % evaluate Q according to trapezium rule

end

