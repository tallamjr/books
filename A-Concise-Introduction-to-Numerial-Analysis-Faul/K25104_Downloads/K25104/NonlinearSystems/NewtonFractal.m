function img = NewtonFractal(P)
% Calculates the basins of attractions when the Newton method for root
%   finding is used on a polynomial of degree at most 7.
% Input arguments:
%   P, vector specifying the coefficents of the polynomial starting with 
%     the coefficient of the highest power
% Output arguments:
%   img, each pixel is coloured according to the root it converges to and 
%     shaded by the number of iterations necessary, the more iterations, 
%     the darker shade

NITER = 100;        % maximum number of iterations
threshold = .001;   % convergence criterion
pixelnum = 1000;    % resolution of image
colorArr = [7,3];   % seven colours specified by their RGB values
%RED
colorArr(1,1) = 1;colorArr(1,2) = 0;colorArr(1,3) = 0;
%GREEN
colorArr(2,1) = 0;colorArr(2,2) = 1;colorArr(2,3) = 0;
%BLUE
colorArr(3,1) = 0;colorArr(3,2) = 0;colorArr(3,3) = 1;
%YELLOW
colorArr(4,1) = 1;colorArr(4,2) = 1;colorArr(4,3) = 0;
%WHITE
colorArr(5,1) = 1;colorArr(5,2) = 0;colorArr(5,3) = 1;
%CYAN
colorArr(6,1) = 0;colorArr(5,2) = 1;colorArr(5,3) = 1;
%RED
colorArr(7,1) = 1;colorArr(6,2) = 1;colorArr(6,3) = 1;

% generate grid over the square [-1, 1] x [-1, 1]
[xs,ys] = meshgrid(linspace(-1,1,pixelnum), linspace(-1,1,pixelnum));
% grid points interpreted as complex numbers, which is an array of
% length pixelnum * pixelnum
solutions = xs(:) + 1i*ys(:);
% array of indices of grid points under consideration
select = 1:numel(xs);
% for each grid point initialize the necessary number of iterations
% to the maximum
niters = NITER*ones(numel(xs), 1);

% calculate the roots of the polynomial
Proots = roots(P);
if isempty(Proots)
    disp('Polynomial has no roots');
    return;
end
% calculate the coefficients of the derivative
Pderivative = zeros(length(P) - 1,1);
for it = 1:length(P)-1
    Pderivative(it)=(length(P)-it)*P(it);
end

for iteration = 1:NITER
    % each iteration considers the entire grid minus the grid points
    % where convergence has occured
    oldi = solutions(select);

    % in newton's method we have z_{i+1} = z_i - p(z_i) / p'(z_i)
    solutions(select) = oldi - polyval(P,oldi) ...
        ./ polyval(Pderivative,oldi);

    % check for convergence or NaN (in case of a division by zero)
    differ = (oldi - solutions(select));
    % logical array marking converged grid points
    converged = abs(differ) < threshold;
    % logical array marking problematic grid points
    problematic = isnan(differ);

    % if converence occured update the necessary number of iterations
    niters(select(converged)) = iteration;
    % for problematic grid points set the number of iterations to the
    % maximum + 1
    niters(select(problematic)) = NITER+1;
    %remove indices of converged or problematic points
    select(converged | problematic) = [];
end

Max = max(niters);
niters = reshape(niters,size(xs));
solutions = reshape(solutions,size(xs));

A = zeros(pixelnum, pixelnum);
B = uint8(round(A * 255));
RowCol = size(solutions);
rows = RowCol(1);
cols = RowCol(2);
for i1 = 1:rows
    for i2 =1:cols
        % to which root did the method converge
        tmp = abs(repmat(solutions(i1,i2), size(Proots))-Proots);
        rootIndex = find(tmp<threshold);
        if ~isempty(rootIndex)
        % color associated with roots and rate of convergence
        B(i1,i2,1)=colorArr(rootIndex,1) * ...
            (1-(niters(i1,i2)/(Max))) * 255;
        B(i1,i2,2)=colorArr(rootIndex,2) * ...
            (1-(niters(i1,i2)/(Max))) * 255;
        B(i1,i2,3)=colorArr(rootIndex,3) * ...
            (1-(niters(i1,i2)/(Max))) * 255;
        end
    end
end
img = image(B);
axis off;
end