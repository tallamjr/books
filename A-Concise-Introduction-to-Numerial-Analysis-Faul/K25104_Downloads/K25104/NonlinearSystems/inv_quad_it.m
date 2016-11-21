function [ x,k ] = inv_quad_it( f,x0,x1,x2,tol,max )
% Implements inverse quadratic interpolation method to find root of f(x)=0
% Input arguments:
%   f, function handle or vector of polynomial coefficients
%   x0,x1,x2, initial iterates
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
    error(['f must be a function handle or vector holding ',...
            'polynomial coefficients']);
end

% start of algorithm
x=zeros(max,1);     % initialize vector to hold iterates
x(1)=x0;x(2)=x1;x(3)=x2;      % initialize first three iterates
f0=feval(f,x(1));           % evaluate f(x0)
f1=feval(f,x(2));           % evaluate f(x1)
f2=feval(f,x(3));           % evaluate f(x2)
k=4;                % initialize iteration counter
l=0;    % initialize another counter to check if iterates are diverging
d0=abs(x2-x1);      % initialize d0 to hold the distance between the 
                    % last two iterates

while abs(f2)>tol && k<=max;   
    
    if abs(f0-f1)<1e-12;
        disp('denominator vanishes'); 
        x=x(1:k); return;     % return vector of iterates so far 
    elseif abs(f1-f2)<1e-12;
        disp('denominator vanishes'); 
        x=x(1:k); return;     % return vector of iterates so far
    elseif abs(f0-f2)<1e-12;
        disp('denominator vanishes'); 
        x=x(1:k); return;     % return vector of iterates so far
    end
    
    % update our estimate of the root
    x(k)=x0*f1*f2/((f0-f1)*(f0-f2))+f0*x1*f2/((f1-f0)*(f1-f2))+...
        f0*f1*x2/((f2-f0)*(f2-f1));   
    
    d1=abs(x(k)-x(k-1));    % update d1
    if d1>d0;   % then distance between succesive iterates is increasing
        l=l+1;  % increment l
        if l>max/10;    % check if the distance between successive iterates
                        % has been increasing for the last max/10
                        % iterations
            disp('distance between succesive iterates is increasing');
            x=x(1:k); return;   % return vector of iterates so far
        end
    else
        l=0;    % reset l
    end
    d0=d1;      % update d0

    x0 = x1;
    x1 = x2;
    x2 = x(k);
    f0=f1;              % update f0
    f1=f2;              % update f1
    f2=feval(f,x(k)); % update f2
    
    k=k+1;  % increment counter
end

if k==max+1;
    disp('maximum number of iterations reached');
end
x=x(k-1);    % set x to the most recent iterate

end