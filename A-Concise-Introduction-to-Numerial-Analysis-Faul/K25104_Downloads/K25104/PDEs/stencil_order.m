function [ final ] = stencil_order( A,order )
% Ttaylor expands the numerical scheme prescribed by the stencil A.
% Input arguments:
%   A, array holding the numerical stencil. The array should be a square 
%   or cube of odd side length. The centre element will be interpreted
%   as the centre of the stencil.
%   order, highest power of h in the output
% Output arguments:
%   final, string holding the expansion of the scheme

[m,n,l]=size(A);  % find the size of A
if m~=n;
    error('input array must be square or cube');
elseif mod(n,2)~=1;
    error('matrix must have odd side length');
elseif mod(order,1)~=0;
    error('input order must be an integer value');
end

c=(n+1)/2;      % find the centre index of the stencil
syms Dx Dy Dz h;     % create symbolic variables Dx,Dy, Dz and h 
e=0;        % initilaize a symbolic variable to hold the error

order = order+1;
if l==1;    % if array is 2D
    for i=1:n;
        for j=1:n;
            tay=taylor(exp((i-c)*Dy*h+(j-c)*Dx*h),Dy,'order',order);
            tay=taylor(tay,Dx,'order',order);
            e=e+A(i,j)*tay;
        end
    end
elseif l==n;    % if array is 3D
    for i=1:n;
        for j=1:n;
            for k=1:n;
            tay=taylor(exp((i-c)*Dy*h+(j-c)*Dx*h+(k-c)*Dz*h),Dy,'order',order);
            tay=taylor(tay,Dx,'order',order);
            tay=taylor(tay,Dz,'order',order);
            e=e+A(i,j,k)*tay;
            end
        end
    end
else
    error('input array must be square or cube');
end

[cx,tx]=coeffs(e,h);
cx=flip(cx);
tx=flip(tx);

final=blanks(1);
hind=1;
first=1;
for k=1:order
    %temp=blanks(1);
    syms a;
    a=k;
    if hind<=length(cx);
        if isequaln(tx(hind),h^a);
            temp1=char(h^a);
            temp2=char(cx(hind));
            if first==1;
                final=strcat(final,temp1,'{',temp2,'}');
                first=0;
            else
                final=strcat(final,' +',temp1,'{',temp2,'}');
            end
            hind=hind+1;
        end
    end

end
end




