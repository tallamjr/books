function [ u ] = hockney( a,b,c,d,f )
% HOCKNEY implements the hockney algorithm without FFT to solve the block 
% TST system Au=f. 
% Input arguments a and b prescribe the diagonal and off diagonal 
% terms respectively of NXN TST matrix B, c and d prescribe the diagonal  
% and off diagonal terms respectively of NXN TST matrix C. A is then the 
% (N^2)X(N^2) block TST matrix with B on the diagonal and C off diagonal.
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

% now form the NxN orthogonal matrix Q
Q=zeros(N);
for i=1:N;
    for j=1:N;
        Q(i,j)=sin(i*j*pi/(N+1));
    end
end
Q=Q*sqrt(2/(N+1));

% form the N matrix vector products c=Qb. we will hold these in an NxN
% array rather than one long vector as this will make column/row reordering
% more intuitive
C=[];     % initialize array
for k=1:N;
    % here we naievely form the products Qf to demonstrate the superiority
    % of the FFT
    for i=1:N;
        temp(i,1)=0;
        for j=1:N;
            temp(i,1)=temp(i,1)+Q(i,j)*f((k-1)*N+j);
        end
    end
    C=horzcat(C,temp);
end

% rearrange columns to rows, this is as simple as applying a transpose 
C=C';

% we now need to solve the N uncoupled systems
y=[];   % initialise y to an empty array
for k=1:N;
    % first form the required TST matrix
    T=(a+2*b*cos(k*pi/(N+1)))*diag(ones(N,1))+...
        (c+2*d*cos(k*pi/(N+1)))*diag(ones(N-1,1),1)+...
        (c+2*d*cos(k*pi/(N+1)))*diag(ones(N-1,1),-1);
    
        L=eye(N);U=T;   % initialise L,U 
    % find LU factorization of T by banded Gaussian elimination
    for j=1:N-1;
        temp=(U(j+1,j)/U(j,j));       % eliminate elements below the diagonal 
        U(j+1,:)=U(j+1,:)-U(j,:)*temp;  % by subtracting a linear combination 
                                    % of rows
                                     
        L(j+1,j)=temp;        % construct L
    end 
    % solve the linear system by back substitution utilising the LU
    % factorization
    U = U - tril(U,-1); % remove rounding errors
    L = L - triu(L,1);
    v=Forward(L,C(:,k));   
    temp=Backward(U,v);    
    y=horzcat(y,temp);
end

% rearrange rows to columns
y=y';
    
u=[];   % initialise variable to hold the solution
for k=1:N;
    temp=Q*y(:,k);
    u=vertcat(u,temp);
end
% note that u is a vector, in the context of fast poisson solvers it can be
% interpreted as a natural ordering by columns of the solution on the grid.
end



        
    

    




