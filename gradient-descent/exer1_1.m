clc;
clear;
close all;


mkdir(fullfile('figures' ,'u3','ab', 'eps'));
mkdir(fullfile('figures' ,'u3','ab', 'svg'));
mkdir(fullfile('figures' ,'u3','xxhat', 'eps'));
mkdir(fullfile('figures' ,'u3','xxhat', 'svg'));
mkdir(fullfile('figures' ,'u3','xdif', 'eps'));
mkdir(fullfile('figures' ,'u3','xdif', 'svg'));

tspan = 0:0.001:30;

am_options = [1, 3, 6, 10, 20, 30, 50, 100];
gamma_options = [1, 2, 5, 10, 25, 30];


initialconditions = zeros(1,5);




u = @(t) 3;


a = 1.5;
b = 2;



for i = 1:length(am_options)
    for j = 1:length(gamma_options)
        fig1 = figure(i);
        fig1.WindowState = 'maximized';
        
        [data, odex] = gradient_descent(tspan, initialconditions,a, b, am_options(i), gamma_options(j), u);
        subplot(length(gamma_options)/2, 2,j);
        plot(tspan, data.x, '-b');
        hold on;
        plot(tspan, data.x_hat, '-.r');
        title(sprintf('Approximated and actual output using the Gradient Descent Method for parameters $\\alpha_m = %d$ and $\\gamma = %d$', am_options(i), gamma_options(j)), 'Interpreter', 'latex');
        ax = gca;
        ax.TitleFontSizeMultiplier = 0.95;
        ylabel('$x$, $\hat{x}$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        legend('$x$', '$\hat{x}$', 'interpreter', 'latex');
        
        
        fig2 = figure(i+length(am_options));
        fig2.WindowState = 'maximized';
        
        subplot(length(gamma_options)/2, 2,j);
        plot(tspan, data.a_hat, tspan, data.b_hat);
        hold on;
        bline = yline(b, '--', '$b$', 'interpreter', 'latex');
        bline.LabelHorizontalAlignment = 'left';
        aline = yline(a,'--', '$\alpha$', 'interpreter', 'latex');
        aline.LabelHorizontalAlignment = 'left';
       
        title(sprintf('Approximated and actual parameters using the Gradient Descent Method for parameters $\\alpha_m = %d$ and $\\gamma = %d$', am_options(i), gamma_options(j)), 'Interpreter', 'latex');
        ax = gca;
        ax.TitleFontSizeMultiplier = 0.95;
        ylabel('$a$, $b$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        legend('$\hat{\alpha}$', '$\hat{b}$', 'interpreter', 'latex');
        
        fig3 = figure(i+2*length(am_options));
        fig3.WindowState = 'maximized';
        
        subplot(length(gamma_options)/2, 2,j);
        plot(tspan,data.x - data.x_hat);
        hold on;
        yline(0, '--');
        ylim([-0.5, 4]);
        title(sprintf('Difference between actual and approximated output using the Gradient Descent Method for parameters $\\alpha_m = %d$ and $\\gamma = %d$', am_options(i), gamma_options(j)), 'Interpreter', 'latex');
        ax = gca;
        ax.TitleFontSizeMultiplier = 0.89;
        ylabel('$x - \hat{x}$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        
    end
    saveas(fig1, fullfile('figures' , 'u3', 'xxhat', 'svg', sprintf('xxhat_am%d.svg', am_options(i))));
    saveas(fig1, fullfile('figures' , 'u3', 'xxhat', 'eps', sprintf('xxhat_am%d.eps', am_options(i))));
    
    saveas(fig2, fullfile('figures' , 'u3', 'ab', 'svg', sprintf('ab_am%d.svg', am_options(i))));
    saveas(fig2, fullfile('figures' , 'u3', 'ab', 'eps', sprintf('ab_am%d.eps', am_options(i))));

    saveas(fig3, fullfile('figures' , 'u3', 'xdif', 'svg', sprintf('xdif_am%d.svg', am_options(i))));
    saveas(fig3, fullfile('figures' , 'u3', 'xdif', 'eps', sprintf('xdif_am%d.eps', am_options(i))));
end

