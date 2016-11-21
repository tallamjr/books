function [ Q ] = composite_rule( f,a,b,n,m,rule )
% Splits the interval [a,b] into n equal subintervals, then numerically
% integrates f on each interval according to the rule prescribed
% Input arguments:
%   f, function handle
%   a,b, integration bounds
%   n, number of subintervals
%   m, number of abscissae (if applicable)
%   rule, rule for numerically integrating each subinterval
%     possible values of rule are: 'midpoint', 'trapezium', 'simpsons', 
%     'simpsons3/8', 'booles', 'milnes', 'gauss_legendre', 'gauss_lobatto' 
%     and 'gauss_radau'.
% Output arguments:
%   Q, value of integral

% first check user inputs
if isa(f,'function_handle')==0;
    error('input must be a function handle');
elseif a>=b;
    error('invalid interval');
elseif mod(n,1)~=0 || n<=0; % if n does not equal zero modulo 1 then it  
                            % is not an integer value
    error('input must be a positive integer');
end

% split interval into n equal subintervals
x=linspace(a,b,n+1);

y=zeros(n,1);% initialize vector to hold contribution from each subinterval
if strcmp(rule,'midpoint');
    for i=1:n;
        y(i)=midpoint_rule(f,x(i),x(i+1));
    end
elseif strcmp(rule,'trapezium');
    for i=1:n;
        y(i)=trapezium_rule(f,x(i),x(i+1));
    end
elseif strcmp(rule,'simpsons');
    for i=1:n;
        y(i)=simpsons_rule(f,x(i),x(i+1));
    end    
elseif strcmp(rule,'simpsons3/8');
    for i=1:n;
        y(i)=simpsons_alt_rule(f,x(i),x(i+1));
    end
elseif strcmp(rule,'booles');
    for i=1:n;
        y(i)=booles_rule(f,x(i),x(i+1));
    end
elseif strcmp(rule,'milnes');
    for i=1:n;
        y(i)=milnes_rule(f,x(i),x(i+1));
    end
elseif strcmp(rule,'gauss_legendre');
    if mod(m,1)~=0||m<=0; 
        error('input must be a positive integer');
    end
    for i=1:n;
        y(i)=gauss_legendre_rule(f,x(i),x(i+1),m);
    end
elseif strcmp(rule,'gauss_lobatto');
    if mod(m,1)~=0||m<=0; 
        error('input must be a positive integer');
    end
    for i=1:n;
        y(i)=gauss_lobatto_rule(f,x(i),x(i+1),m);
    end
elseif strcmp(rule,'gauss_radau');
    if mod(m,1)~=0||m<=0; 
        error('input must be a positive integer');
    end
    for i=1:n;
        y(i)=gauss_radau_rule(f,x(i),x(i+1),m);
    end
else 
    error('please enter a valid rule');
end

Q=sum(y);   % sum contribution from each subinterval to get y

end

