function [ Q ] = booles_rule( f,a,b )
% Employs Boole's rule to integrate f between a and b
% Input arguments:
%   f, function handle
%   a,b, integration bounds, a<b
% Outpur arguments:
%   Q, value of integral 

% first check user inputs
if isa(f,'function_handle')==0;
    error('input must be a function handle');
elseif a>=b;
    error('invalid interval');
end

fa=feval(f,a);          % evaluate f(a) 
f1=feval(f,(3*a+b)/4);  % evaluate f((3a+b)/4))
fm=feval(f,(a+b)/2);    % evalaute f at midpoint
f2=feval(f,(a+3*b)/4);  % evaluate f((a+3b)/4))
fb=feval(f,b);          % evaluate f(b)

% evaluate Q according to Boole's rule
Q=(b-a)*(7*fa+32*f1+12*fm+32*f2+7*fb)/90; 

end

