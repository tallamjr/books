function [ Q ] = milnes_rule( f,a,b )
% Employs Milne's rule to integrate f between a and b
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

f1=feval(f,(3*a+b)/4);      % evaluate f at (3a+b)/4
f2=feval(f,(a+b)/2);        % evaluate f at (a+b)/2
f3=feval(f,(a+3*b)/4);      % evaluate f at (a+3b)/4

Q=(b-a)*(2*f1-f2+2*f3)/3;   % evalaute Q according to Milne's rule

end

