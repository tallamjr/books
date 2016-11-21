function [ p ] = RK_order( b,c,A )
% Identifies the order up to 4 of the Runge-Kutta scheme given by A,b,c.
% Input arguments:
%   b, column vector holding the Runge-Kutta weights
%   c, column vector holding the Runge-Kutta nodes
%   A, matrix holding the Runge-Kutta coefficients
% Output arguments:
%   p, the order of the scheme up to 4.

% check user inputs
[Arows,Acols]=size(A);
[brows,bcols]=size(b);
[crows,ccols]=size(c);
if Arows~=Acols;    
    error('input must be a square matrix');
elseif bcols~=1 || ccols~=1;
    error('input must be column vectors');
elseif brows~=Arows || crows~=Arows;
    error('input dimensions do not agree');
end

E=1e-12;    % we use this as a small tolerance on either side of each 
            % condition, in case of possible rounding errors    
p=0;           
if (sum(b)>1-E) && (sum(b)<1+E);                    % condition 1
    p=1;                    % update p
    if (b'*c>1/2-E) && (b'*c<1/2+E);                % condition 2
        p=2;                % update p
        c2=c.^2;            % '.^' performs element-wise exponentiation
        if (b'*c2>1/3-E) && (b'*c2<1/3+E);          % condition 3
            if (b'*A*c>1/6-E) && (b'*A*c<1/6+E)     % condition 4
                p=3;        % update p
            end
        else return; 
        end
    else return; 
    end
else return; 
end

c3=c.^3;
if (b'*c3>1/4-E) & (b'*c3<1/4+E);                       % condition 5
    bc=b.*c;                % '.*' performs element-wise multiplication
    if (bc'*A*c>1/8-E) && (bc'*A*c<1/8+E);              % condition 6
        if (b'*A*c2>1/12-E) && (b'*A*c2<1/12+E);        % condition 7
            if (b'*A*A*c>1/24-E) && (b'*A*A*c<1/24+E)   % condition 8
                p=4;        % update p
            end
        end
    end
end


end

