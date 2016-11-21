function [ soln, timer ] = poisson_5point_hock( f,g,a,b,N )
% Solves the poisson equation (grad^2)u(x,y)=f(x,y) on the 2D domain 
% [a,b]x[a,b], with Dirichlet boundary condition u(x,y)=g(x,y) on
% the boundary of the domain.  This is achieved by overlaying an  
% equispaced grid containing N^2 interior points and applying the 5 point   
% stencil. This function employs the hockney method without FFT to solve  
% the linear system arising from the application of the stencil, and
% incorporates a timer so its speed can be compared with other solvers.
% Input arguments:
%   f, function handle holding the source function
%   g, function handle prescribing boundary condition
%   a,b, prescribing the domain
%   N, integer value prescribing the number of interior grid points in
%     each direction.
% Output arguments:
%   soln, array holding the solution values at each of the interior
%   grid points
%   timer, time elapsed for comparison with other methods

% first check user inputs 
if isa(f,'function_handle')==0;
    error('f must be a function handle');
elseif isa(g,'function_handle')==0;
    error('g must be a function handle');
elseif a>=b;
    error('must have a<b');
elseif mod(N,1)~=0;
    error('N must be an integer value');
end

h=(b-a)/(N+1);  % store the value of h for hygiene

B=zeros(N);% initialize array to hold the source function and boundary data
% fill B with the data from the source function on the grid
for j=1:N;
    for i=1:N;
        B(i,j)=feval(f,a+i*h,a+j*h);
    end
end
% let y be a natural ordering of B
y=B(:,1);
for k=2:N;
    y=vertcat(y,B(:,k));
end

y=y*(h^2);  % scale y

% incorporate boundary conditions at the left and right sides of the grid
for i=1:N;
    y(i)=y(i)-feval(g,a,a+i*h);
    y((N-1)*N+i)=y((N-1)*N+i)-feval(g,b,a+i*h);
end

% incorporate boundary conditions on top and bottom sides of the grid
for j=1:N;
    y((j-1)*N+1)=y((j-1)*N+1)-feval(g,a+j*h,a);
    y(j*N)=y(j*N)-feval(g,a+j*h,b);
end

tic;    % start stopwatch

u=hockney(-4,1,1,0,y);  % solve block TST system by Hockney method

timer=toc;   % stop stopwatch

soln(:,1)=u(1:N);    % initialize first column of output

% reverse the natural ordering so soln is an array representing the N^2
% interior grid points.
for k=1:N-1;
    soln=horzcat(soln,u(k*N+1:(k+1)*N));
end

end


