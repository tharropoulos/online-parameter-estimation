clc;
clear;
close all;


mkdir(fullfile('figures',  'par', 'xxhat', 'svg'));
mkdir(fullfile('figures',  'par', 'xxhat', 'eps'));
mkdir(fullfile('figures',  'par', 'ab', 'svg'));
mkdir(fullfile('figures',  'par', 'ab', 'eps'));
mkdir(fullfile('figures',  'par', 'xdif', 'svg'));
mkdir(fullfile('figures',  'par', 'xdif', 'eps'));

tspan = 0:0.001:30;


gamma1_options = [0.1, 0.3, 0.5, 1, 4, 5, 10, 30];
gamma2_options = [0.1, 0.4, 0.7, 2, 5, 8, 24, 40];

initialconditions = zeros(1,4);


n_0 = 1.5;
f = 20;

u = @(t) 3 * cos(2*t);
n = @(t) n_0 * sin(2*pi*f*t);




a = 1.5;
b = 2;

for i = 1:length(gamma1_options)
    for j = 1:length(gamma2_options)
        fig1 = figure(i);
        fig1.WindowState = 'maximized';
      
        [data, odex] = lyapunov_par(tspan, initialconditions, a, b, gamma1_options(i), gamma2_options(j), u, n);
        subplot(length(gamma1_options)/2, 2,j);
        plot(tspan, data.x, '-b');
        hold on;
        plot(tspan, data.x_hat, '-.r');
        title(sprintf('Approximated and actual output using the Lyapunov Parallel  Method for parameters $\\gamma_1 = %.1f$ and $\\gamma_2 = %.1f$', gamma1_options(i), gamma2_options(j)), 'Interpreter', 'latex');
        ax = gca;
        ax.TitleFontSizeMultiplier = 0.95;
        ylabel('$x$, $\hat{x}$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        legend('$x$', '$\hat{x}$', 'interpreter', 'latex');
        
        fig2 = figure(i+length(gamma1_options));
        fig2.WindowState = 'maximized';
        
        subplot(length(gamma1_options)/2, 2,j);
        plot(tspan, data.a_hat, tspan, data.b_hat);
        hold on;
        bline = yline(b, '--', '$b$', 'interpreter', 'latex');
        bline.LabelHorizontalAlignment = 'left';
        aline = yline(a,'--', '$\alpha$', 'interpreter', 'latex');
        aline.LabelHorizontalAlignment = 'left';
       
        title(sprintf('Approximated and actual parameters using the Lyapunov Parallel Method for parameters $\\gamma_1 = %.1f$ and $\\gamma_2 = %.1f$', gamma1_options(i), gamma2_options(j)), 'Interpreter', 'latex');
        ax = gca;
        ax.TitleFontSizeMultiplier = 0.95;
        ylabel('$a$, $b$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        legend('$\hat{\alpha}$', '$\hat{b}$', 'interpreter', 'latex');
        
        
        
        fig3 = figure(i+2*length(gamma1_options));
        fig3.WindowState = 'maximized';
        
        subplot(length(gamma1_options)/2, 2,j);
        plot(tspan,data.x - data.x_hat);
        hold on;
        yline(0, '--');
%         ylim([-0.5, 4]);
        title(sprintf('Difference between actual and approximated output using the Lyapunov Parallel Method for parameters $\\gamma_1 = %.1f$ and $\\gamma_2 = %.1f$', gamma1_options(i), gamma2_options(j)), 'Interpreter', 'latex');
        ax = gca;
        ax.TitleFontSizeMultiplier = 0.89;
        ylabel('$x - \hat{x}$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        
    end
    saveas(fig1, fullfile('figures',  'par', 'xxhat', 'svg', sprintf('xxhat_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig1, fullfile('figures',  'par', 'xxhat', 'eps', sprintf('xxhat_g1(%.1f).eps', gamma1_options(i))));
    
    saveas(fig2, fullfile('figures',  'par', 'ab', 'svg', sprintf('ab_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig2, fullfile('figures',  'par', 'ab', 'eps', sprintf('ab_g1(%.1f).eps', gamma1_options(i))));
    
    saveas(fig3, fullfile('figures',  'par', 'xdif', 'svg', sprintf('xdif_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig3, fullfile('figures',  'par', 'xdif', 'eps', sprintf('xdif_g1(%.1f).eps', gamma1_options(i))));
    
end
