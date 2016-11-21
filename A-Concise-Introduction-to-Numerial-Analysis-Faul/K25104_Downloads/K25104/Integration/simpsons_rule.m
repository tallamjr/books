function [ Q ] = simpsons_rule( f,a,b )
% Employs Simpson's rule to integrate f between a and b
% Input arguments:
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

fa=feval(f,a);          % evaluate f(a)
fm=feval(f,(a+b)/2);    % evaluate f at the midpoint
fb=feval(f,b);          % evaluate f(b) 

Q=(b-a)*(fa+4*fm+fb)/6; % evaluate Q according to Simpson's rule

end

