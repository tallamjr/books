function [ Q ] = simpsons_alt_rule( f,a,b )
% Employs Simpson's 3/8 rule to integrate f between a and b
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
fc=feval(f,(2*a+b)/3);  % evaluate f((2a+b)/3))
fd=feval(f,(a+2*b)/3);  % evaluate f((a+2b)/3))
fb=feval(f,b);          % evaluate f(b) 

Q=(b-a)*(fa+3*fc+3*fd+fb)/8;   % evaluate Q according to Simpson's 3/8 rule
end

