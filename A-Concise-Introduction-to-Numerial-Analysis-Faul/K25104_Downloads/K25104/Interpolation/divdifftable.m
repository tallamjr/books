function [d] = divdifftable( nodes, values )
% Calculates the divided difference table
% Input arguments:
%   nodes, interpolation points 
%   values, function values
% Output arguments:
%   d, square matrix containing the divided difference table in its 
%     lower triangular part.

% Note: The divided differences used in Newton's interpolation 
% formula are the diagonal entries of d.

[n,m]=size(nodes);      % finding the size of nodes
[k,l] = size(values); 	% finding the size of values
if m~=1 || l~=1
    error('input need to be column vectors');
elseif n~=k
    error('input dimensions do not agree');
end
d(:,1) = values; % the first column of the divided difference table are 
                 % the function values
for j=2:n        % generate the divided difference table one column after
                 % the other
    for i=j:n    % generate the entries on or below the diagonal
                 % using the recurrence relation for divided differences
        if nodes(i-j+1) == nodes(i)
            error('nodes coincide');
        else
            d(i,j)= ( d(i-1,j-1)-d(i,j-1)) / (nodes(i-j+1)-nodes(i));
        end
    end
end
end

