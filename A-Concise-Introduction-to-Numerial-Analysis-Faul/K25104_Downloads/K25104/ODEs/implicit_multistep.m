function [ y,t,err ] = implicit_multistep( f,t0,y0,h,T,rho, sigma, analytic )
% Implements an implicit multistep method to solve y'=f.
% If the analytic solution is given, the error is calculated.
% Input arguments:
%   f, function handle; f=@(t,y)()
%   t0, y0 initial conditions
%   h, step size
%   T, end time
%   rho, sigma, column vectors prescribing the method. 
%     The first element should contain the coefficient associated with l=0.
%   analytic (optional), function handle to the analytic solution; 
%     analytic=@(t)()
% Output arguments:
%   y, vector of solution at times defined by t
%   t, vector of time steps
%   err, pointwise error. If the analytic solution is not provided, err will be empty

% check user input
[n,m]=size(rho);    % finding the size of rho
[s,t]=size(sigma);  % finding the size of sigma
if m~=1 || t~=1;
    error('inputs must be column vectors');
elseif n~=s;
    error('inputs must be the same length');
    % the method is an (s-1)-step method
elseif isa(f,'function_handle')==0
    error('input must be a function handle');
elseif h<=0;    
    error('step size must be positive');
elseif T<=t0;
    error('invalid interval');
end

s1 = s-1; % number of steps in the method
n=ceil((T-t0)/h);   % calculate the ceiling of (T-t0)/h. 
                    % This gives the number of steps
t=linspace(t0,t0+h*n,n+1); t=t';    % initialize vector of time steps
y=zeros(n+1,1);     % initialize vector to hold y values
fy=zeros(s1,1);      % holds function values at s time steps

% Take first s-1 steps with a one step method. 
% This is not necessary if it is a one step method.
if s>1;
    [a,b,~]=backward_euler(f,t0,y0,h,t0+s1*h,analytic);
    y(1:s1)=a(1:s1);
    for i=1:s1;
        fy(i)=f(b(i),a(i));
    end
else
    y(1)=y0;
    fy(1)=f(t0,y0);
end

for k=0:n-s;
    % find next iterate as zero of a non-linear function
    g = @(x) rho(s)*x + (rho(1:s1)'*y(k+1:s1+k)) - ...
        h*(sigma(1:s1)'*fy) - h*sigma(s)*f(t(s+k),x);
    y(s+k)= fzero(g,y(s+k-1)); 
    fy(1:s1-1)=fy(2:s1);
    fy(s1)=f(t(s+k),y(s+k));
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

