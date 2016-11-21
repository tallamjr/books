function L = Lagrangecardinal( nodes,k )
% Returns the k-th Lagrange cardinal polynomial for the given nodes
% Input arguments:
%   nodes, the interpolation nodes
%   k, integer specifying one of the nodes
% Output arguments:
%   L, symbolic variable of the Lagrange polynomial

[n,m]=size(nodes);  % finding the size of nodes
if m~=1;
    error('input needs to be a column vector');
elseif mod(k,1)~=0 || k<=0 || k>n; % if k does not equal zero modulo 1   
                            % then it is not an integer value and it has to
                            % specify a valid index
    error('input must specify a valid index');
end
syms x;     % create a symbolic variable
syms L; % initialize symbolic variable to hold kth lagrange polynomial
L=1;    % set to unity
for j=1:n;
    if j==k;    
        % do nothing
    else
        L=L*(x-nodes(j))/(nodes(k)-nodes(j));   % add another term to 
                                                % the product
    end
end