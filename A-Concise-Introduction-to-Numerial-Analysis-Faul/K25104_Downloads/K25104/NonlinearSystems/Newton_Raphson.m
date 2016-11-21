function [ x,k ] = Newton_Raphson( f,initial,tol,max )
% Implements Newton method to find root of f(x)=0
% Input arguments:
%   f, function handle or vector of polynomial coefficients
%   initial, initial iterate
%   tol, tolerance
%   max, maximum number of iterations
% Output arguments:
%   x, solution
%   k, number of iterations to convergence

% first check user inputs
if tol<=0;
    error('tolerance must be positive');
elseif max<=0;
    error('maximum number of iterations must be positive');
elseif isa(f,'sym');
    df = diff(f);
    f = matlabFunction(f);
    df = matlabFunction(df);
elseif isa(f,'double'); 
    [n,m]=size(f);  % find the size of f
    if n~=1 && m~=1; % then f is not a vector
        error(['input must be a symbolic function or vector holding ',...
            'polynomial coefficients']);
    else 
        v=poly2sym(f);  % this converts the vector of coefficients to an
                        % expression for the polynomial
        df = diff(v);
        f=matlabFunction(v);    % this converts the expression to a 
                                % function handle
        df = matlabFunction(df);
    end
else
    error(['input must be a symbolic function or vector holding ',...
            'polynomial coefficients']);
end

% start of algorithm
x=zeros(max,1);         % initialise vector to hold iterates
x(1)=initial;           % initialize x(1)
fx=feval(f,x(1));       % evaluate f(x)
divx=feval(df,x(1));   % evaluate f'(x)
k=2;                % initialize iteration counter
l=0;    % initialize another counter to check if iterates are diverging
d0=0;   % initialize d0 to zero

while abs(fx)>tol && k<=max   
    
    x(k)=x(k-1)-fx/divx;    % update our estimate of the root
    
    test=find(x(1:k-1)==x(k));
    if isempty(test)==0;    % if our estimate of the root matches any of 
                            % the previous estimates then we fall into 
                            % an infinite loop
        disp('algorithm fell into infinite loop');
        x=x(1:k); return;   % return vector of iterates so far
    end
    
    d1=abs(x(k)-x(k-1));    % calculate d1
    if d1>d0;   % then distance between succesive iterates is increasing
        l=l+1;  % increment l
        if l>20;
            disp('distance between succesive iterates is increasing');
            x=x(1:k); return;   % return vector of iterates so far
        end
    else
        l=0;    % reset l
    end
    d0=d1;      % update d0

    fx=feval(f,x(k));       % evaluate f(x)
    divx=feval(df,x(k));   % evaluate f'(x)
    
    if abs(divx)<1e-12;
        disp('denominator vanishes'); 
        x=x(1:k); return;   % return vector of iterates so far
    end
    
    k=k+1;  % increment counter
end

if k==max+1;
    disp('maximum number of iterations reached');
end
x=x(k-1);    % set x to the most recent iterate

end
