% Usage example of Lagrangecardinal
% related to Exercise 3.1

nodes = [0; 1; 2; 3];
values = [1; 1; 1; 1];
plot(nodes, values, 'o');
hold on;
for k= 1:size(nodes,1);
    L = Lagrangecardinal( nodes,k )
    ezplot(matlabFunction(L),[-1, 4]);
end
title([]);
    