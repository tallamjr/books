function [ y,t,err ] = trapezoidal_rule( f,t0,y0,h,T,analytic )
% Implements the trapezoidal rule to solve y'=f.
% If the analytic solution is given, the error is calculated.
% Input arguments:
%   f, function handle; f=@(t,y)()
%   t0, y0 initial conditions
%   h, step size
%   T, end time
%   analytic (optional), function handle to the analytic solution; 
%     analytic=@(t)()
% Output arguments:
%   y, vector of solution at times defined by t
%   t, vector of time steps
%   err, pointwise error. If the analytic solution is not provided, 
%     err will be empty

% check user input
if isa(f,'function_handle')==0
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

for k=2:n+1;        % move forward in time with trapezoidal rule
    % find next iterate as zero of a non-linear function
    g = @(x) (x - y(k-1) - h/2 * (f(t(k-1),y(k-1)) + f(t(k),x)));
    y(k)=fzero(g,y(k-1));
end

% calculate error if possible
err=[]; % initialize err
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

