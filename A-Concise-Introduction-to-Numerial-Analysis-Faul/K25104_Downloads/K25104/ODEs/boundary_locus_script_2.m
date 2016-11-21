% Usage example for boundary_locus
% related to the Theta methods

n=100;
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Theta methods', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', ...
    'FontWeight', 'bold', ...
    'FontSize',12)
for k=1:10
    subplot(5,2,k);
    theta = 1 - (k-1)/10;
    rho = [1; -1];
    sigma = [1 - theta; theta];
    [ z ] = boundary_locus( rho,sigma,n );
    plot(z);
    title(['theta = ', num2str(theta)]);
    axis([-3 3 -3 3]);
    grid on;
end
