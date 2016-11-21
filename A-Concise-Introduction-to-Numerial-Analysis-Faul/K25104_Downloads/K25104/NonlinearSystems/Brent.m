function [ x,k,z ] = Brent( f,a,b,tol,max )
% implements Brent's algorithm to find a solution of f(x)=0;
% Input arguments:
%   f, function handle or vector of polynomial coefficients
%   b, initial iterate
%   c, initial contrapoint
%   tol, tolerance
%   max, maximum number of iterations
% Output arguments:
%   x, solution
%   k, number of iterations
%   z, holds information which method was used for each iteration; 
%     1 -> Binary search
%     2 -> Inverse quadratic interpolation
%     3 -> Linear interpolation

% first check user inputs
if tol<=0;
    error('tolerance must be positive');
elseif max<=0;
    error('maximum number of iterations must be positive');
elseif isa(f,'function_handle');
    % do nothing
elseif isa(f,'double'); 
    [n,m]=size(f);  % find the size of f
    if n~=1 && m~=1; % then f is not a vector
        error(['input must be a function handle or vector holding ',...
            'polynomial coefficients']);
    else 
        v=poly2sym(f);  % this converts the vector of coefficients to
                        % an expression for the polynomial
        f=matlabFunction(v);    % this converts the expression to a 
                                % function handle
    end
else
    error(['input must be a function handle or vector holding ',...
            'polynomial coefficients']);
end
 
delta=tol/2;        % set delta

fa=feval(f,a);      % evaluate f(a)
fb=feval(f,b);      % evaluate f(b)
k=1;                % initialize iteration counter

if fa==0;      % check in case the solution is at one of the endpoints
    x=a; return;
elseif fb==0;
    x=b; return;
elseif fa*fb>0;   % if f(a),f(b) have the same sign
        error('function values at endpoints have the same sign');
end

if abs(fb)<abs(fa);     % then we need to interchange a and b, so the 
                        % iterate is the best approximation to x
    swap=a;             % hold a
    a=b; a=swap;        % swap a and b
    fa=feval(f,a);      % revaluate f(a)
    fb=feval(f,b);      % revaluate f(b)
end

c=a;            % we will need an extra variables to hold the previous 
d=a;            % iterates, in the first instance set these to a.
fc=fa; fd=fa;       % store f(c), f(d)

z=zeros(max,1);     % z will be a variable which holds information on 
z(1)=1;             % whether the previous iteration used binary
                    % search, linear interpolation or IQI.                     
                    


% start of algorithm            
while abs(a-b)>tol && k<=max;
    
    if fa~=fb && fb~=fc && fc~=fa;  % then choose s according to 
                                  % inverse quadratic interpolation
        s=a*fb*fc/((fa-fb)*(fa-fc))+fa*b*fc/((fb-fa)*(fb-fc))...
            +fa*fb*c/((fc-fa)*(fc-fb));
        temp=2;     % temporarily store this choice of interpolation
    else                          % if any of fa,fb,fc coincide, 
                                  % choose s according to linear
                                  % interpolation
        s=b-fb*(b-a)/(fb-fa);
        temp=3;     % temporarily store this choice of interpolation
    end
    
    if or((s<(3*a+b)/4 & s<b),(s>(3*a+b)/4 & s>b)); % if s is not 
                                                    % between (3*a+b)/4
                                                    % and b
        s=(a+b)/2; z(k+1)=1; % choose s according to binary search
                             % and set z=1
    elseif z(k)==1 && abs(b-c)<delta;
        s=(a+b)/2; z(k+1)=1; % choose s according to binary search
                             % and set z=1
    elseif z(k)~=1 && abs(c-d)<delta;
        s=(a+b)/2; z(k+1)=1; % choose s according to binary search 
                             % and set z=1
    elseif z(k)==1 && abs(s-b)>=abs(b-a)/2;
        s=(a+b)/2; z(k+1)=1; % choose s according to binary search 
                             % and set z=1
    elseif z(k)~=1 && abs(s-b)>=abs(b-d)/2;
        s=(a+b)/2; z(k+1)=1; % choose s according to binary search 
                             % and set z=1
    else
        z(k+1)=temp;
    end
    
    fs=feval(f,s);     % evaluate f(s)
    if fs==0;          % check if we have found the solution
        x=s;
        return;
    end
     
    d=c;    % update d
    c=b;    % update c
    fa=feval(f,a);     % evaluate f(a)
    fb=feval(f,b);     % evaluate f(b)
    fd=feval(f,d);     % evaluate f(d) 
    fc=feval(f,c);     % evaluate f(c) 
    
    if fa*fs<0;   % if f(a) and f(s) have different signs
        b=s;        % update b
        fb=feval(f,b);     % update f(b)
    else 
        a=s;        % update a
        fa=feval(f,a);     % update f(a)
    end
    
    if abs(fa)<abs(fb);     % then interchange a and b, so the iterate
                            % is the best approximation to x
        swap=a;             % hold a
        a=b; b=swap;        % swap b and a
        swap=fa;            % hold f(a)
        fa=fb;  fb=swap;    % swap f(a) and f(b)
    end
 
    if fb==0;      % check if we have found the solution
        x=a;
    end
    
    k=k+1;  % increment k
end

x=b;        % set x to the most recent iterate
z=z(1:k);   % shorten z 

if k==max+1;
    disp('maximum number of iterations reached');
end
    
end