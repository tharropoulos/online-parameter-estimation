clc;
clear;
close all;


mkdir(fullfile('figures','def-noise', 'xxhat', 'svg'));
mkdir(fullfile('figures','def-noise', 'xxhat', 'eps'));
mkdir(fullfile('figures','def-noise', 'ab', 'svg'));
mkdir(fullfile('figures','def-noise', 'ab', 'eps'));
mkdir(fullfile('figures','def-noise', 'xdif', 'svg'));
mkdir(fullfile('figures','def-noise', 'xdif', 'eps'));

tspan = 0:0.001:30;


gamma1_options = [0.1, 0.3, 0.5, 1, 4, 5, 10, 30];
gamma2_options = [0.1, 0.4, 0.7, 2, 5, 8, 24, 40];

initialconditions = zeros(1,4);



n_0 = 1.5;
f = 20;

u = @(t) 3 * cos(2*t);
n = @(t)  n_0 * sin(2*pi*f*t);




a = 1.5;
b = 2;





ctr = 1;

for i = 1:length(gamma1_options)
    for j = 1:length(gamma2_options)
        fig1 = figure(i);
        fig1.WindowState = 'maximized';
      
        [data, odex] = lyapunov_par(tspan, initialconditions, a, b, gamma1_options(i), gamma2_options(j), u, n);
        
        
        datas(ctr).xmse = data.xmse;
        datas(ctr).amse = data.amse;
        datas(ctr).bmse = data.bmse;
        datas(ctr).general_mse = data.general_mse;
        datas(ctr).gamma1 = gamma1_options(i);
        datas(ctr).gamma2 = gamma2_options(j);
        datas(ctr).x = data.x;
        datas(ctr).x_hat = data.x_hat;
        datas(ctr).a_hat = data.a_hat;
        datas(ctr).b_hat = data.b_hat;
              
        
        ctr = ctr+1;
  
        
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
    saveas(fig1, fullfile('figures',  'def-noise', 'xxhat', 'svg', sprintf('xxhat_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig1, fullfile('figures',  'def-noise', 'xxhat', 'eps', sprintf('xxhat_g1(%.1f).eps', gamma1_options(i))));
    
    saveas(fig2, fullfile('figures',  'def-noise', 'ab', 'svg', sprintf('ab_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig2, fullfile('figures',  'def-noise', 'ab', 'eps', sprintf('ab_g1(%.1f).eps', gamma1_options(i))));
    
    saveas(fig3, fullfile('figures',  'def-noise', 'xdif', 'svg', sprintf('xdif_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig3, fullfile('figures',  'def-noise', 'xdif', 'eps', sprintf('xdif_g1(%.1f).eps', gamma1_options(i))));
    
end
[min_xmse, indexx] = min([datas.xmse]);
[min_amse, indexa] = min([datas.amse]);
[min_bmse, indexb] = min([datas.bmse]);
[min_general_mse, index_general] = min([datas.general_mse]);
X =  ['gamma1 = ', num2str(datas(indexx).gamma1), ', gamma2 =  ', num2str(datas(indexx).gamma2), ' for minimum square error for output']; 
disp(X);
A =  ['gamma1 =  ', num2str(datas(indexa).gamma1), ', gamma2 =  ', num2str(datas(indexa).gamma2), ' for minimum square error for a']; 
disp(A);
B =  ['gamma1 = ', num2str(datas(indexb).gamma1), ', gamma2 =  ', num2str(datas(indexb).gamma2), ' for minimum square error for b']; 
disp(B);
G =  ['gamma1 = ', num2str(datas(index_general).gamma1), ', gamma2 =  ', num2str(datas(index_general).gamma2), ' for general minimum square error']; 
disp(G);
        