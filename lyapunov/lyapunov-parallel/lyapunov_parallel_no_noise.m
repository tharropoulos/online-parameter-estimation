clc;
clear;
close all;

%% Making Directories %%

mkdir(fullfile('figures','no-noise', 'xxhat', 'svg'));
mkdir(fullfile('figures','no-noise', 'xxhat', 'eps'));
mkdir(fullfile('figures','no-noise', 'ab', 'svg'));
mkdir(fullfile('figures','no-noise', 'ab', 'eps'));
mkdir(fullfile('figures','no-noise', 'xdif', 'svg'));
mkdir(fullfile('figures','no-noise', 'xdif', 'eps'));

%% Initializing %%
tspan = 0:0.001:30;


gamma1_options = [0.1, 0.3, 0.5, 1, 4, 5, 10, 30];
gamma2_options = [0.1, 0.4, 0.7, 2, 5, 8, 24, 40];

initialconditions = zeros(1,4);

gamma1 = 30;
gamma2 = 40;


n_0 = 1.5;
f = 20;

u = @(t) 3 * cos(2*t);
n = @(t)  0;



a = 1.5;
b = 2;





ctr = 1;
 %% Approximations and Plots %%
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
    %% Save Plots %%
    saveas(fig1, fullfile('figures',  'no-noise', 'xxhat', 'svg', sprintf('xxhat_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig1, fullfile('figures',  'no-noise', 'xxhat', 'eps', sprintf('xxhat_g1(%.1f).eps', gamma1_options(i))));
    
    saveas(fig2, fullfile('figures',  'no-noise', 'ab', 'svg', sprintf('ab_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig2, fullfile('figures',  'no-noise', 'ab', 'eps', sprintf('ab_g1(%.1f).eps', gamma1_options(i))));
    
    saveas(fig3, fullfile('figures',  'no-noise', 'xdif', 'svg', sprintf('xdif_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig3, fullfile('figures',  'no-noise', 'xdif', 'eps', sprintf('xdif_g1(%.1f).eps', gamma1_options(i))));
    
end
%% minimum and maximum mse%%
[min_xmse, min_indexx] = min([datas.xmse]);
[min_amse, min_indexa] = min([datas.amse]);
[min_bmse, min_indexb] = min([datas.bmse]);
[min_general_mse, min_index_general] = min([datas.general_mse]);
[max_xmse, max_indexx] = max([datas.xmse]);
[max_amse, max_indexa] = max([datas.amse]);
[max_bmse, max_indexb] = max([datas.bmse]);
[max_general_mse, max_index_general] = max([datas.general_mse]);

Xmin = ['gamma1 = ', num2str(datas(min_indexx).gamma1), ', gamma 2 = ', num2str(datas(min_indexx).gamma2), ' for minimum square error for output ', num2str(min_xmse)];
disp(Xmin);

Amin = ['gamma1 = ', num2str(datas(min_indexa).gamma1), ', gamma 2 = ', num2str(datas(min_indexa).gamma2), ' for minimum square error for a ', num2str(min_amse)];
disp(Amin);

Bmin = ['gamma1 = ', num2str(datas(min_indexb).gamma1), ', gamma 2 = ', num2str(datas(min_indexb).gamma2),' for minimum square error for b ', num2str(min_bmse)];
disp(Bmin);

Gmin = ['gamma1 = ', num2str(datas(min_index_general).gamma1), ', gamma 2 = ', num2str(datas(min_index_general).gamma2), ' for minimum square error for general ', num2str(min_general_mse)];
disp(Gmin);

fprintf('\n');

Xmax = ['gamma1 = ', num2str(datas(max_indexx).gamma1), ', gamma 2 = ', num2str(datas(max_indexx).gamma2),' for maximum square error for output ', num2str(max_xmse)];
disp(Xmax);

Amax = ['gamma1 = ', num2str(datas(max_indexa).gamma1), ', gamma 2 = ', num2str(datas(max_indexa).gamma2), ' for maximum square error for a ', num2str(max_amse)];
disp(Amax);

Bmax = ['gamma1 = ', num2str(datas(max_indexb).gamma1), ', gamma 2 = ', ' for maximum square error for b ', num2str(max_bmse)];
disp(Bmax);

Gmax = ['gamma1 = ', num2str(datas(max_index_general).gamma1), ', gamma 2 = ', num2str(datas(max_index_general).gamma2), ' for maximum square error for general ', num2str(max_general_mse)];
disp(Gmax);
        
