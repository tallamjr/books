function [ soln, timer ] = poisson_9point( f,g,a,b,N )
% Solves the Poisson equation (grad^2)u(x,y)=f(x,y) on the
% 2D domain [a,b]x[a,b], with Dirichlet boundary condition u(x,y)=g(x,y) on
% the boundary of the domain.  This is achieved by overlaying an  
% equispaced grid containing N^2 interior points and applying the 9 point   
% stencil. This function uses MATLAB library to solve the linear system
% arising from the application of the stencil, and incorporates a timer so 
% its speed can be compared with other solvers. Note that MATLAB puts a 
% limit on the size of an array as a percentage of RAM, this method forms 
% an (N^2)x(N^2) array, so if N is chosen too large it may return an error.
% Input arguments:
%   f, function handle holding the source function
%   g, function handle prescribing boundary condition
%   a,b prescribing the domain
%   N, integer value prescribing the number of interior grid points in 
%     each direction.
% Output arguments:
%   soln, array holding the solution values at each of the interior
%     grid points
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
    y(i)=y(i)-(1/6)*feval(g,a,a+(i-1)*h)-(2/3)*feval(g,a,a+i*h)-(1/6)*feval(g,a,a+(i+1)*h);
    y((N-1)*N+i)=y((N-1)*N+i)-(1/6)*feval(g,b,a+(i-1)*h)-(2/3)*feval(g,b,a+i*h)-(1/6)*feval(g,b,a+(i+1)*h);
end

% incorporate boundary conditions on top and bottom sides of the grid
for j=1:N;
    y((j-1)*N+1)=y((j-1)*N+1)-(1/6)*feval(g,a+(j-1)*h,a)-(2/3)*feval(g,a+j*h,a)-(1/6)*feval(g,a+(j+1)*h,a);
    y(j*N)=y(j*N)-(1/6)*feval(g,a+(j-1)*h,b)-(2/3)*feval(g,a+j*h,b)-(1/6)*feval(g,a+(j+1)*h,b);
end

% this point we've overcompensated on the corner elements, so fix this
y(1)=y(1)+(1/6)*feval(g,a,a);
y(N)=y(N)+(1/6)*feval(g,a,b);
y(N*(N-1)+1)=y(N*(N-1)+1)+(1/6)*feval(g,b,a);
y(N*N)=y(N*N)+(1/6)*feval(g,b,b);

tic;    % start stopwatch
% we need to construct the block tridiagonal matrix which arises by
% applying the 9 point formula with natural ordering

% the fastest way to do this is to create a TST matrix first
A=-(10/3)*diag(ones(N*N,1))+(2/3)*diag(ones(N*N-1,1),1)+(2/3)*diag(ones(N*N-1,1),-1)+...
    (2/3)*diag(ones(N*(N-1),1),N)+(1/6)*diag(ones(N*(N-1)+1,1),N-1)+(1/6)*diag(ones(N*(N-1)-1,1),N+1)+(2/3)*diag(ones(N*(N-1),1),-N)...
    +(1/6)*diag(ones(N*(N-1)+1,1),-N+1)+(1/6)*diag(ones(N*(N-1)-1,1),-N-1);

% then remove the unwanted entries
for k=1:N-1;
    A(N*k,N*k+1)=0;
    A(N*k+1,N*k)=0;
end
for k=1:N-2;
    A(N*k+1,N*(k+1))=0;
    A(N*k,N*(k+1)+1)=0;
    A(N*(k+1)+1,N*k)=0;
    A(N*(k+1),N*k+1)=0;
end
A(1,N)=0;
A(N,1)=0;
A(N*N,N*(N-1)+1)=0;
A(N*(N-1)+1,N*N)=0;

A_inv=inv(A);   % calculate the inverse of A

u=zeros(N*N,1); % initialize vector to hold the solution
u=A_inv*y;      % calculate u

timer=toc;      % stop stopwatch

soln(:,1)=u(1:N);    % initialize first column of output

% reverse the natural ordering so soln is an array representing the N^2
% interior grid points.
for k=1:N-1;
    soln=horzcat(soln,u(k*N+1:(k+1)*N));
end

end

