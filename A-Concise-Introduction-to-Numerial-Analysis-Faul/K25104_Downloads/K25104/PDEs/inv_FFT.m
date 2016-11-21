function [ y ] = inv_FFT( x )
% Computes the inverse discrete fourier transform of sequence x
% Input arguments:
%   x, row vector of length 2^n, where n is an integer value
%   y, inverse fourier transform.

[b,a]=size(x);
if b~=1;
    error('input must be a row vector');
end
l=log2(a);
if mod(l,1)~=0; 
    error('input must have length 2^n for some integer n');
end

A(1,:)=x;   % initialise array 

for k=1:l-1;
    p=2^(l-k+1);    % length of vectors in current row
    q=2^(k-1);      % number of vectors in current row 
    for n=1:q
    A(2,p*(n-1)+1:(p/2)*(2*n-1))=A(1,p*(n-1)+1:2:p*n);  % extract odd elements
    A(2,(p/2)*(2*n-1)+1:p*n)=A(1,p*(n-1)+2:2:p*n);  % extract even elements
    end
    A(1,:)=A(2,:);
end

B(1,:)=A(1,:);  % first row of B holds the ordered singletons

for k=1:l;
    w=exp((pi*1i)/(2^(k-1)));    % save the relevant primitive root of unity
    p=2^(k-1);      % length of vectors in current row
    q=2^(l-k+1);    % number of vectors in current row
    for n=1:q/2
        left=B(1,p*(2*n-2)+1:p*(2*n-1));
        right=B(1,p*(2*n-1)+1:p*2*n);
   
        B(1,2*p*(n-1)+1:2*p*n)=[left,left];
        for m=1:p;
            B(1,2*p*(n-1)+m)=B(1,2*p*(n-1)+m)+right(m)*w^(m-1);
            B(1,2*p*(n-1)+m+p)=B(1,2*p*(n-1)+m+p)+right(m)*w^(p+m-1);
        end
    end
end

y=B(1,:);

end

