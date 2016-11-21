function [ x,k ] = Bus_Dekker( f,a,b,tol,max )
% Implements the Bus and Dekker algorithm to find a solution of f(x)=0;
% Input arguments:
%   f, function handle or vector of polynomial coefficients
%   b, initial iterate
%   a, initial contrapoint
%   tol, tolerance
%   max, maximum number of iterations
% Output arguments:
%   x, solution
%   k, number of iterations

% first check user inputs
if a>=b;    
    error('specifed interval invalid');
elseif tol<=0;
    error('tolerance must be positive');
elseif max<=0;
    error('maximum number of iterations must be positive');
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
    error(['input must be a function handle or vector holding ',...
            'polynomial coefficients']);
end

% start of algorithm
fa=feval(f,a);     % evaluate f(a)
fb=feval(f,b);     % evaluate f(b)

if fa==0;          % check incase the solution is at one of the endpoints
    x=a; return;
elseif fb==0;   
    x=b; return;
elseif fa*fb>0;   % if f(a),f(b) have the same sign
        error('function values at endpoints have the same sign');
end

c=a;    % we will need to hold the previous two iterates, so initialize 
        % another variable. In the first instance set c=a
fc=fa;      % store f(c)
k=0;        % initialize counter

while abs(b-a)>tol && k<=max;
    
    m=(a+b)/2;         % calculate the midpoint of the interval
    s=b-((b-c)*fb)/(fb-fc);     % calculate the approximation to x 
                                % given by secant method
    temp=b;    % hold b
    
    if or((s>b & s<m),(s<b & s>m)); % check if s lies between b and m
        b=s;   % update b
    else
        b=m;   % update b
    end
    fb=feval(f,b);      % evaluate f(b)
    
    if fa==0;           % check if a is a root
        x=a; return;
    elseif fb==0;       % check if b is a root
        x=b; return;
    elseif fa*fb>0;     %  if f(a),f(b) have the same sign
        a=c;            % update a
        fa=feval(f,a);  % evaluate f(a)
    end
    
    c=temp;             % update c
    fc=feval(f,c);      % evaluate f(c)
    
    
    if abs(fa)<abs(fb); % then we need to interchange a and b, so that 
                        % the iterate is the best approximation to x
        swap=a;         % hold a
        a=b; b=swap;    % swap b and a
        fa=feval(f,a);  % revaluate f(a)
        fb=feval(f,b);  % revaluate f(b)
    end
   
    k=k+1;      % increment k
end

x=b;    % set x to be the last iterate

if k==max+1;
    disp('maximum number of iterations reached');
end

end
    

    
    

