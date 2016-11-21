function [ y,t,err ] = explicit_RK( f,t0,y0,h,T,b,c,A,analytic )
% Implements an explicit Runge-Kutta method to solve y'=f.
% If the analytic solution is given, the error is calculated.
% Input arguments:
%   f, function handle; f=@(t,y)()
%   t0, y0 initial conditions
%   h, step size
%   T, end time
%   b, column vector holding the Runge-Kutta weights
%   c, column vector holding the Runge-Kutta nodes
%   A, matrix holding the coefficients a(i,j) which prescribe the method.
%   analytic (optional), function handle to the analytic solution; 
%     analytic=@(t)()
% Output arguments:
%   y, vector of solution at times defined by t
%   t, vector of time steps
%   err, pointwise error. If the analytic solution is not provided, err will be empty

% first check user inputs
[Arows,Acols]=size(A);
[brows,bcols]=size(b);
[crows,ccols]=size(c);
if Arows~=Acols;    
    error('matrix must be a square matrix');
elseif ~istril(A)
    error(['matrix must be strictly lower triangular, else the prescribed '...
        'method is not explicit']);
elseif norm(diag(A))~=0;
    error(['matrix must be strictly lower triangular, else the prescribed '...
        'method is not explicit']);
elseif bcols~=1 || ccols~=1;
    error('input must be column vectors');
elseif brows~=Arows || crows~=Arows;
    error('dimensions do not match');
elseif ~isequal(c, sum(A,2));
    error('the method is not consistent');
elseif isa(f,'function_handle')==0
    error('input must be a function handle');
elseif h<=0;    
    error('step size must be positive');
elseif T<=t0;
    error('invalid interval');
end

n=ceil((T-t0)/h);   % calculate the ceiling of (T-t0)/h. 
                    % This gives the number of steps
t=linspace(t0,t0+h*n,n+1); t=t';    % initialize vector of time steps
y=zeros(n+1,1);     % initialize vector to hold y values
y(1)=y0;            % set initial y value

k=zeros(Arows,1);      % initialize vector k

for i=1:n;
    k(1) = feval(f,t(i),y(i));    % because the method is explicit and consistent
    for j=2:Arows;
        s=0;              % initialize sum
        for l=1:j-1;   
            s=s+A(j,l)*k(l);    % calculate sum
        end
        k(j)=feval(f,t(i)+c(j)*h,y(i)+h*s);   % calculate k(j)
    end
    y(i+1)=y(i)+h*(b'*k);   % calculate y(i+1)
end

if exist('analytic')==1;
    if isa(analytic,'function_handle')==0;
        disp('analytic must be a function handle')
        return;
    else
        true=analytic(t);
        err=abs(true-y);
    end
end

end
