function [ y ] = rec_inv_FFT( x )
% Computes the inverse discrete fourier transform of sequence x recursively
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

if a==1;
    y = x;
else
    e = x(1:2:a); % extract even indices starting with 0
    o = x(2:2:a);  % extract odd indices starting with 0
    e = rec_inv_FFT(e);
    o = rec_inv_FFT(o);
    ahalf = a/2;
    w=exp(pi*1i/ahalf);    % relevant primitive root of unity
    for l=1:ahalf;
        y(l) = e(l) + w^(l-1) * o(l);
        y(l+ahalf) = e(l) - w^(l-1) * o(l);
    end
end
end