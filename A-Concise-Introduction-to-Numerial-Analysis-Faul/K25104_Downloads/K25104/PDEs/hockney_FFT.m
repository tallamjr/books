function [ u ] = hockney_FFT( a,b,c,d,f )
% Implements the Hockney algorithm with FFT to solve the block 
% TST system Au=f.  
% Input arguments a and b prescribe the diagonal and off diagonal 
% terms respectively of NXN TST matrix B, c and d prescribe the diagonal  
% and off diagonal terms respectively of NXN TST matrix C. A is then the 
% (N^2)X(N^2) block TST matrix with B on the diagonal and C off diagonal.
% Input argument f is a column vector holding the data on the right hand
% side.
% Input arguments:
%   a,b,c,d, Specifying diagonal entries
%   f, column vector holding the data on the right hand side. 
% Output arguments:
%   u, vector holding the solution.

[n,M]=size(f);
if M~=1;
    error('f must be a column vector');
end
N=sqrt(n);

% form the N matrix vector products c=Qb using FFT. we will hold these in an NxN
% array rather than one long vector as this will make column/row reordering
% more intuitive
C=[];    % initialize array
for k=1:N;
    u=f((k-1)*N+1:k*N)';   
    u=horzcat(0,u,zeros(1,N+1));  % extend the vector to make it consistent 
                                  % with the Fast Fourier Transform
    temp=inv_FFT(u);              % apply FFT
    temp=temp(2:N+1);             % cut off unwanted parts
    temp=sqrt(2/(N+1))*imag(temp);  
    temp=temp';
    C=horzcat(C,temp);
    clear temp;
end

% rearrange columns to rows, this is as simple as applying a traspose 
C=C';

% we now need to solve the N uncoupled systems
y=[];   % initialize y to an empty array
for k=1:N;
    % first form the required TST matrix
    T=(a+2*b*cos(k*pi/(N+1)))*diag(ones(N,1))+...
        (c+2*d*cos(k*pi/(N+1)))*diag(ones(N-1,1),1)+...
        (c+2*d*cos(k*pi/(N+1)))*diag(ones(N-1,1),-1);
    
    L=eye(N);U=T;   % initialize L,U 
    % find LU factorization of T by banded Gaussian elimination
    for j=1:N-1;
        temp=(U(j+1,j)/U(j,j));       % eliminate elements below the diagonal 
        U(j+1,:)=U(j+1,:)-U(j,:)*temp;  % by subtracting a linear combination 
                                    % of rows
                                     
        L(j+1,j)=temp;        % construct L
    end 
    % solve the linear system by back substitution utilizing the LU
    % factorization
    U = U - tril(U,-1); % remove rounding errors
    L = L - triu(L,1);
    v=Forward(L,C(:,k));   
    temp=Backward(U,v);    
    y=horzcat(y,temp);
end


u=[];   % initialize array to hold solution
for k=1:N;
    in=y(k,:);   
    in=horzcat(0,in,zeros(1,N+1));  % extend the vector to make it consistent 
                                  % with the Fast Fourier Transform
    temp=inv_FFT(in);             % apply FFT
    temp=temp(2:N+1);             % cut off unwanted parts
    temp=sqrt(2/(N+1))*imag(temp);  
    temp=temp';
    u=vertcat(u,temp);
    clear temp;
end
% note that u is a vector, in the context of fast Poisson solvers it can be
% interpreted as a natural ordering by columns of the solution on the grid.
end