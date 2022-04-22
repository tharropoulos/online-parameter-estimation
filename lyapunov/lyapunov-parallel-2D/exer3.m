clc;
clear;
close all;

%% Making Directories %%

mkdir(fullfile('figures', 'xxhat1', 'svg'));
mkdir(fullfile('figures', 'xxhat1', 'eps'));
mkdir(fullfile('figures', 'xxhat2', 'svg'));
mkdir(fullfile('figures', 'xxhat2', 'eps'));
mkdir(fullfile('figures', 'a', 'svg'));
mkdir(fullfile('figures', 'a', 'eps'));
mkdir(fullfile('figures', 'b', 'svg'));
mkdir(fullfile('figures', 'b', 'eps'));
mkdir(fullfile('figures', 'xdif1', 'svg'));
mkdir(fullfile('figures', 'xdif1', 'eps'));
mkdir(fullfile('figures', 'xdif2', 'svg'));
mkdir(fullfile('figures', 'xdif2', 'eps'));

%% Initializing %%
tspan = 0:0.001:100;


gamma1_options = [0.5, 1, 2, 8, 20, 40];
gamma2_options = [0.5, 1, 2, 8, 20, 40];

initialconditions = zeros(1,10);


u = @(t) 7.5 * cos(3 * t) + 10 * cos(2 * t);



A = [-0.5, -3; 4 -2];
B  = [1;1.4];


        
 
     



ctr = 1;
 %% Approximations and Plots %%
for i = 1:length(gamma1_options)
    for j = 1:length(gamma2_options)
        fig1 = figure(i);
        fig1.WindowState = 'maximized';
      
        [data, odex] = lyapunov_par_2D(tspan, initialconditions, A, B, gamma1_options(i), gamma2_options(j), u);
        
        
        datas(ctr).xmse = data.xmse;
        datas(ctr).amse = data.amse;
        datas(ctr).bmse = data.bmse;
        datas(ctr).gamma1 = gamma1_options(i);
        datas(ctr).gamma2 = gamma2_options(j);
        datas(ctr).x = data.x;
        datas(ctr).x_hat = data.x_hat;
        datas(ctr).A_hat = data.A_hat;
        datas(ctr).B_hat = data.B_hat;
              
        
        ctr = ctr+1;
  
        
        subplot(length(gamma1_options)/2, 2,j);
        plot(tspan, data.x(:,1), '-b');
        hold on;
        plot(tspan, data.x_hat(:,1), '-.r');
        title(sprintf('Approximated and actual output using the Lyapunov Parallel  Method for parameters $\\gamma_1 = %.1f$ and $\\gamma_2 = %.1f$', gamma1_options(i), gamma2_options(j)), 'Interpreter', 'latex');
        ax = gca;
        ax.TitleFontSizeMultiplier = 0.95;
        ylabel('$x_1$, $\hat{x}_1$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        legend('$x_1$', '$\hat{x}_1$', 'interpreter', 'latex');
        
        fig2 = figure(i+length(gamma1_options));
        fig2.WindowState = 'maximized';
        
        subplot(length(gamma1_options)/2, 2,j);
        plot(tspan, data.x(:,2), '-b');
        hold on;
        plot(tspan, data.x_hat(:,2), '-.r');
        title(sprintf('Approximated and actual output using the Lyapunov Parallel  Method for parameters $\\gamma_1 = %.1f$ and $\\gamma_2 = %.1f$', gamma1_options(i), gamma2_options(j)), 'Interpreter', 'latex');
        ax = gca;
        ax.TitleFontSizeMultiplier = 0.95;
        ylabel('$x_2$, $\hat{x}_2$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        legend('$x_2$', '$\hat{x}_2$', 'interpreter', 'latex');
        
        fig3 = figure(i+2*length(gamma1_options));
        fig3.WindowState = 'maximized';
        
        subplot(length(gamma1_options)/2, 2,j);
        plot(tspan, cell2mat(data.A_hat(1,1)),tspan, cell2mat(data.A_hat(1,2)),tspan, cell2mat(data.A_hat(2,1)),tspan, cell2mat(data.A_hat(2,2)));
       
        aline = yline(A(1,1),'--', '$\alpha_{11}$', 'interpreter', 'latex');
        aline.LabelHorizontalAlignment = 'left';
        aline = yline(A(1,2),'--', '$\alpha_{12}$', 'interpreter', 'latex');
        aline.LabelHorizontalAlignment = 'left';
        aline = yline(A(2,1),'--', '$\alpha_{21}$', 'interpreter', 'latex');
        aline.LabelHorizontalAlignment = 'left';
        aline = yline(A(2,2),'--', '$\alpha_{22}$', 'interpreter', 'latex');
        aline.LabelHorizontalAlignment = 'left';
       
       
        title(sprintf('Approximated and actual parameters using the Lyapunov Parallel Method for parameters $\\gamma_1 = %.1f$ and $\\gamma_2 = %.1f$', gamma1_options(i), gamma2_options(j)), 'Interpreter', 'latex');
        ax = gca;
        ax.TitleFontSizeMultiplier = 0.95;
        ylabel('$\hat{A}$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        legend('$\hat{\alpha}_{11}$', '$\hat{\alpha}_{12}$', '$\hat{\alpha}_{21}$', '$\hat{\alpha}_{22}$', 'interpreter', 'latex');
        
        
        
        fig4 = figure(i+3*length(gamma1_options));
        fig4.WindowState = 'maximized';
        
        
        subplot(length(gamma1_options)/2, 2,j);
        
        plot(tspan,cell2mat(data.B_hat(1)), tspan, cell2mat(data.B_hat(2)));
        
        bline = yline(B(1),'--', '$b_{1}$', 'interpreter', 'latex');
        bline.LabelHorizontalAlignment = 'left';
        bline = yline(B(2),'--', '$b_{2}$', 'interpreter', 'latex');
        bline.LabelHorizontalAlignment = 'left';
        
        
        title(sprintf('Approximated and actual parameters using the Lyapunov Parallel Method for parameters $\\gamma_1 = %.1f$ and $\\gamma_2 = %.1f$', gamma1_options(i), gamma2_options(j)), 'Interpreter', 'latex');
        ax = gca;
        ax.TitleFontSizeMultiplier = 0.95;
        ylabel('$\hat{B}$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        legend('$\hat{b}_{1}$', '$b_{2}$', 'interpreter', 'latex');
        
        fig5 = figure(i+4*length(gamma1_options));
        fig5.WindowState = 'maximized';      
        subplot(length(gamma1_options)/2, 2,j);
        plot(tspan,data.x(:,1) - data.x_hat(:,1));
        
        hold on;
        yline(0, '--');
%         ylim([-0.5, 4]);
        title(sprintf('Difference between actual and approximated output using the Lyapunov Parallel Method for parameters $\\gamma_1 = %.1f$ and $\\gamma_2 = %.1f$', gamma1_options(i), gamma2_options(j)), 'Interpreter', 'latex');
        ax = gca;
        ax.TitleFontSizeMultiplier = 0.89;
        ylabel('$x_1 - \hat{x}_1$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        
        
        
        fig6 = figure(i+5*length(gamma1_options));
        fig6.WindowState = 'maximized';
        
        subplot(length(gamma1_options)/2, 2,j); 
        plot(tspan,data.x(:,2) - data.x_hat(:,2));
        
        hold on;
        yline(0, '--');
%         ylim([-0.5, 4]);
        title(sprintf('Difference between actual and approximated output using the Lyapunov Parallel Method for parameters $\\gamma_1 = %.1f$ and $\\gamma_2 = %.1f$', gamma1_options(i), gamma2_options(j)), 'Interpreter', 'latex');
        ax = gca;
        ax.TitleFontSizeMultiplier = 0.89;
        ylabel('$x_2 - \hat{x}_2$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
    end
   %% Save Plots %%
    saveas(fig1, fullfile('figures',   'xxhat1', 'svg', sprintf('xxhat1_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig1, fullfile('figures',   'xxhat1', 'eps', sprintf('xxhat1_g1(%.1f).eps', gamma1_options(i))));
    
    saveas(fig2, fullfile('figures',   'xxhat2', 'svg', sprintf('xxhat2_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig2, fullfile('figures',   'xxhat2', 'eps', sprintf('xxhat2_g1(%.1f).eps', gamma1_options(i))));
    
    saveas(fig3, fullfile('figures',   'a', 'svg', sprintf('a_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig3, fullfile('figures',   'a', 'eps', sprintf('a_g1(%.1f).eps', gamma1_options(i))));
    
    saveas(fig4, fullfile('figures',   'b', 'svg', sprintf('b_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig4, fullfile('figures',   'b', 'eps', sprintf('b_g1(%.1f).eps', gamma1_options(i))));
    
    
    saveas(fig5, fullfile('figures',   'xdif1', 'svg', sprintf('xdif1_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig5, fullfile('figures',   'xdif1', 'eps', sprintf('xdif1_g1(%.1f).eps', gamma1_options(i))));
    
    saveas(fig6, fullfile('figures',   'xdif2', 'svg', sprintf('xdif2_g1(%.1f).svg', gamma1_options(i))));
    saveas(fig6, fullfile('figures',   'xdif2', 'eps', sprintf('xdif2_g1(%.1f).eps', gamma1_options(i))));
    
    
    
end
%% minimum and maximum mse couldn't work on it on time will come back%%

% for k = 1:length(datas)
%     XMSE = [XMSE; cell2mat(datas(k).xmse(1)), cell2mat(datas(k).xmse(2))];
%     AMSE  = [AMSE; cell2mat(datas(k).amse(1,1)), cell2mat(datas(k).amse(1,2)); cell2mat(datas(k).amse(2,1)), cell2mat(datas(k).amse(1,2))];
%     BMSE  = [BMSE, cell2mat(datas(k).bmse(1)); cell2mat(datas(k).bmse(2))];
% end
% 
% 
% [min_xmse, min_indexx] = min([datas.xmse]);
% [min_amse, min_indexa] = min([datas.amse]);
% [min_bmse, min_indexb] = min([datas.bmse]);
% % [min_general_mse, min_index_general] = min([datas.general_mse]);
% [max_xmse, max_indexx] = max([datas.xmse]);
% [max_amse, max_indexa] = max([datas.amse]);
% [max_bmse, max_indexb] = max([datas.bmse]);
% % [max_general_mse, max_index_general] = max([datas.general_mse]);
% 
% Xmin = ['gamma1 = ', num2str(datas(min_indexx).gamma1), ', gamma 2 = ', num2str(datas(min_indexx).gamma2), ' for minimum square error for output ', num2str(min_xmse)];
% disp(Xmin);
% 
% Amin = ['gamma1 = ', num2str(datas(min_indexa).gamma1), ', gamma 2 = ', num2str(datas(min_indexa).gamma2), ' for minimum square error for a ', num2str(min_amse)];
% disp(Amin);
% 
% Bmin = ['gamma1 = ', num2str(datas(min_indexb).gamma1), ', gamma 2 = ', num2str(datas(min_indexb).gamma2),' for minimum square error for b ', num2str(min_bmse)];
% disp(Bmin);
% 
% Gmin = ['gamma1 = ', num2str(datas(min_index_general).gamma1), ', gamma 2 = ', num2str(datas(min_index_general).gamma2), ' for minimum square error for general ', num2str(min_general_mse)];
% disp(Gmin);
% 
% fprintf('\n');
% 
% Xmax = ['gamma1 = ', num2str(datas(max_indexx).gamma1), ', gamma 2 = ', num2str(datas(max_indexx).gamma2),' for maximum square error for output ', num2str(max_xmse)];
% disp(Xmax);
% 
% Amax = ['gamma1 = ', num2str(datas(max_indexa).gamma1), ', gamma 2 = ', num2str(datas(max_indexa).gamma2), ' for maximum square error for a ', num2str(max_amse)];
% disp(Amax);
% 
% Bmax = ['gamma1 = ', num2str(datas(max_indexb).gamma1), ', gamma 2 = ', ' for maximum square error for b ', num2str(max_bmse)];
% disp(Bmax);
% 
% Gmax = ['gamma1 = ', num2str(datas(max_index_general).gamma1), ', gamma 2 = ', num2str(datas(max_index_general).gamma2), ' for maximum square error for general ', num2str(max_general_mse)];
% disp(Gmax);
%         
