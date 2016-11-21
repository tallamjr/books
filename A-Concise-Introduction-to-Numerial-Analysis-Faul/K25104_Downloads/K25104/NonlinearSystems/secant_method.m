function [ x,k ] = secant_method( f,a,b,tol,max )
% Implements secant method algorithm to find root of f(x)=0
% Input arguments:
%   f, function handle or vector of polynomial coeffiencts
%   a,b, end points of initial search interval
%   tol, tolerance
%   max, maximum number of iterations
% Output arguments:
%   x, solution
%   k, number of iterations to convergence

% first check user inputs
if a>=b;    
    error('specifed interval invalid');
elseif tol<=0;
    error('tol must be positive');
elseif max<=0;
    error('max must be positive');
elseif isa(f,'function_handle');
    % do nothing
elseif isa(f,'double'); 
    [n,m]=size(f);  % find the size of f
    if n~=1 && m~=1; % then f is not a vector
        error(['Input must be a function handle or vector holding ',...
            'polynomial coefficients']);
    else 
        v=poly2sym(f);  % this converts the vector of coefficients to an
                        % expression for the polynomial
        f=matlabFunction(v);    % this converts the expression to a 
                                % function handle
    end
else
    error(['input must be a function handle or vector holding ',...
            'polynomial coefficients']);
end

% start of algorithm
fa=feval(f,a);  % evaluate f(a)
fb=feval(f,b);  % evaluate f(b)
k=0;            % initialize counter

if fa==0;           % then a is a root
    x=a; return;
elseif fb==0;       % then b is a root
    x=b; return;    
end
fc=fb;              % initialise f_c to start loop

while abs(fc)>tol && k<=max;    
    
    denom=fb-fa;
    if abs(denom)<1e-12; % check size of denominator
        disp(['denominator gets very close to zero, possible'...
            'loss of significance'])    % display warning
    end
    
    c=b-fb*((b-a)/(denom));     % calculate next iterate
    
    fc=feval(f,c);              % evaluate f(c)
    a=b;        % update a
    b=c;        % update b
    fa=fb;      % update f(a)
    fb=fc;      % update f(b)
   
    k=k+1;      % increment counter
end

x=c;    % set x to the most recent iterate

if k==max+1;
    disp('maximum number of iterations reached');
end

end
