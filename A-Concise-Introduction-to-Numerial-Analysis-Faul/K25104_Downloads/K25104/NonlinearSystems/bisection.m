function [ x,k ] = bisection( f,a,b,tol,max )
% Implements bisection method to find a root, f(x)=0
% Input arguments:
%   f, function handle or vector of polynomial coeffiencts
%   a,b, end points of initial interval containing a root
%   tol, tolerance
%   max, maximum number of iterations
% Output arguments:
%   x, solution
%   k, number of iterations to convergence

% first check user inputs
if a>=b;    
    error('specifed interval invalid');
elseif tol<=0;
    error('tolerance must be positive');
elseif max<=0;
    error('max must be positive');
elseif isa(f,'function_handle');
    % do nothing
elseif isa(f,'double'); 
    [n,m]=size(f);  % find the size of f
    if n~=1 && m~=1; % then f is not a vector
        error(['input must be a function handle or vector holding ',...
            'polynomial coefficients']);
    else 
        v=poly2sym(f);  % this converts the vector of coefficients to an
                        % expression for the polynomial
        f=matlabFunction(v);    % this converts the expression to a 
                                % function handle
    end
else
    error(['Input must be a function handle or vector holding ',...
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
elseif fa*fb>0;     % then f(a),f(b) have the same sign
    error('function values at endpoints have the same sign');
end

while abs(fa)>tol && abs(fb)>tol && k<=max;   
    
    m=(a+b)/2;      % calculate midpoint, m 
    fm=feval(f,m);  % evaluate f(m)
    
    if fm==0;       % then m is a root
        x=m; return;
    end
    
    if fm*fa<0;     % then f(a) and f(m) have opposite signs
        b=m;        % update b
        fb=fm;      % update f(b)
    else            % f(m) and f(b) have opposite signs
        a=m;        % update a
        fa=fm;      % update f(a)
    end
    
    k=k+1;      % increment counter
end

if abs(fa)<tol;
    x=a;        % set x to a
else
    x=b;        % set x to b
end

if k==max+1;
    disp('maximum number of iteratons met');
end

end
    