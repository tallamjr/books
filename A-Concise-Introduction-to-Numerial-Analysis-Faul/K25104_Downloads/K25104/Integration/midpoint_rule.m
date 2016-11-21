function [ Q ] = midpoint_rule( f,a,b )
% Employs the midpoint rule to integrate f between a and b
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

m=(a+b)/2;      % calculate midpoint
fm=feval(f,m);  % evaluate f at the midpoint

Q=(b-a)*fm; % evaluate Q according to midpoint rule

end

