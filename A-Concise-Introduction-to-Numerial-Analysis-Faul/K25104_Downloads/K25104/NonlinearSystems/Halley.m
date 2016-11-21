function [ x,k ] = Halley( f,initial,tol,max )
% Implements Halley's method to find root of f(x)=0
% Input arguments:
%   f, vector of polynomial coefficients
%   initial, initial iterate
%   tol, tolerance
%   max, maximum number of iterations
% Output arguments:
%   x, solution
%   k, number of iterations to convergence

% f input argument, function handle or vector of polynomial coefficients
% initial input argument, initial iterate
% tol input argument, tolerance
% max input argument, maximum iterations
% x output argument, solution
% k output argument, number of iterations to convergence

% first check user inputs
if tol<=0;
    error('tolerance must be positive');
elseif max<=0;
    error('maximum number of iterations must be positive');
elseif isa(f,'sym');
    df1 = diff(f);
    df2 = diff(df1);
    f = matlabFunction(f);
    df1 = matlabFunction(df1);
    df2 = matlabFunction(df2);
elseif isa(f,'double'); 
    [n,m]=size(f);  % find the size of f
    if n~=1 && m~=1; % then f is not a vector
        error(['input must be a symbolic function or vector holding ',...
            'polynomial coefficients']);
    else 
        v=poly2sym(f);  % this converts the vector of coefficients to an
                        % expression for the polynomial
        df1 = diff(v);
        df2 = diff(df1);
        f=matlabFunction(v);    % this converts the expression to a 
                                % function handle
        df1 = matlabFunction(df1);
        df2 = matlabFunction(df2);
    end
else
    error(['input must be a symbolic function or vector holding ',...
            'polynomial coefficients']);
end

% start of algorithm
x=zeros(max,1);       % initialize vector to hold iterates
x(1)=initial;         % initialize x(1)
fx=feval(f,x(1));        % evaluate f(x)
df1x=feval(df1,x(1));  % evaluate f'(x)
df2x=feval(df2,x(1));  % evaluate f''(x)
k=2;                % initialise iteration counter
l=0;    % initialise another counter to check if iterates are diverging
d0=0;   % initialise d0 to zero

while abs(fx)>tol && k<=max;   
    
    denom=2*(df1x)^2-fx*df2x;  % evaluate the denominator
    if abs(denom)<1e-12;
        disp('denominator vanishes'); 
        x=x(1:k); return;     % return vector of iterates so far
    end
    
    % update our estimate of the root
    x(k)=x(k-1)-(2*fx*df1x)/(denom);    
    
    test=find(x(1:k-1)==x(k));
    if isempty(test)==0;    % if our estimate of the root matches any of 
                            % the previous estimates then we fall into 
                            % an infinite loop
        disp('algorithm fell into infinite loop');
        x=x(1:k); return;     % return vector of iterates so far
    end
    
    d1=abs(x(k)-x(k-1));    % calculate d1
    if d1>d0;   % then distance between succesive iterates is increasing
        l=l+1;  % increment l
        if l>20;
            disp('distance between succesive iterates is increasing');
            x=x(1:k); return;     % return vector of iterates so far
        end
    else
        l=0;    % reset l
    end
    d0=d1;      % update d0

    fx=feval(f,x(k));            % evaluate f(x)
    df1x=feval(df1,x(k));      % evaluate f'(x)
    df2x=feval(df2,x(k));      % evaluate f''(x)
    
    k=k+1;  % increment counter
end

if k==max+1;
    disp('maximum number of iterations reached');
end
x=x(k-1);    % set x to the most recent iterate

end
