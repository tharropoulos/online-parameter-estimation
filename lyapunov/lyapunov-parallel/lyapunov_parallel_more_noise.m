clc;
clear;
close all;


mkdir(fullfile('figures','more-noise', 'xxhat', 'svg'));
mkdir(fullfile('figures','more-noise', 'xxhat', 'eps'));
mkdir(fullfile('figures','more-noise', 'ab', 'svg'));
mkdir(fullfile('figures','more-noise', 'ab', 'eps'));
mkdir(fullfile('figures','more-noise', 'xdif', 'svg'));
mkdir(fullfile('figures','more-noise', 'xdif', 'eps'));

tspan = 0:0.001:30;

gamma1 = 10;
gamma2 = 24;

foptions = [20 40 80 160 240];
n0options = [1.5 3 6 12 24 36];

initialconditions = zeros(1,4);



n_0 = 1.5;
f = 20;

u = @(t) 3 * cos(2*t);
n = @(t)  n_0 * sin(2*pi*f*t);




a = 1.5;
b = 2;





ctr = 1;

for i = 1:length(foptions)
    for j = 1:length(n0options)
        fig1 = figure(i);
        fig1.WindowState = 'maximized';
        
        n = @(t)  n0options(j) * sin(2*pi*foptions(i)*t);

        [data, odex] = lyapunov_par(tspan, initialconditions, a, b, gamma1, gamma2, u, n);
        
        
        datas(ctr).xmse = data.xmse;
        datas(ctr).amse = data.amse;
        datas(ctr).bmse = data.bmse;
        datas(ctr).general_mse = data.general_mse;
        datas(ctr).f = foptions(i);
        datas(ctr).n0 = n0options(j);
        datas(ctr).x = data.x;
        datas(ctr).x_hat = data.x_hat;
        datas(ctr).a_hat = data.a_hat;
        datas(ctr).b_hat = data.b_hat;
              
        
        ctr = ctr+1;
  
        
        subplot(length(n0options)/2, 2,j);
        plot(tspan, data.x, '-b');
        hold on;
        plot(tspan, data.x_hat, '-.r');
        title(sprintf('Approximated and actual output using the Lyapunov Parallel  Method for $n(t) = %.1fsin(2\\pi %d t)$', n0options(j), foptions(i)), 'Interpreter', 'latex');
%         ax = gca;
%         ax.TitleFontSizeMultiplier = 0.9;
        ylabel('$x$, $\hat{x}$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        legend('$x$', '$\hat{x}$', 'interpreter', 'latex');
        
        fig2 = figure(i+length(foptions));
        fig2.WindowState = 'maximized';
        
        subplot(length(n0options)/2, 2,j);
        plot(tspan, data.a_hat, tspan, data.b_hat);
        hold on;
        bline = yline(b, '--', '$b$', 'interpreter', 'latex');
        bline.LabelHorizontalAlignment = 'left';
        aline = yline(a,'--', '$\alpha$', 'interpreter', 'latex');
        aline.LabelHorizontalAlignment = 'left';
       
        title(sprintf('Approximated and actual parameters using the Lyapunov Parallel Method for $n(t) = %.1fsin(2\\pi %d t)$', n0options(j), foptions(i)), 'Interpreter', 'latex');
%         ax = gca;
%         ax.TitleFontSizeMultiplier = 0.9;
        ylabel('$a$, $b$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        legend('$\hat{\alpha}$', '$\hat{b}$', 'interpreter', 'latex');
        
        
        
        fig3 = figure(i+2*length(foptions));
        fig3.WindowState = 'maximized';
        
        subplot(length(n0options)/2, 2,j);
        plot(tspan,data.x - data.x_hat);
        hold on;
        yline(0, '--');
%         ylim([-0.5, 4]);
       title(sprintf('Difference between actual and approximated output using the Lyapunov Parallel Method for  $n(t) = %.1fsin(2\\pi %d t)$', n0options(j), foptions(i)), 'Interpreter', 'latex');
        ylabel('$x - \hat{x}$', 'interpreter', 'latex');
        xlabel('$t$', 'interpreter', 'latex');
        
    end
    saveas(fig1, fullfile('figures',  'more-noise', 'xxhat', 'svg', sprintf('xxhat_f(%.1f).svg', foptions(i))));
    saveas(fig1, fullfile('figures',  'more-noise', 'xxhat', 'eps', sprintf('xxhat_f(%.1f).eps', foptions(i))));
    
    saveas(fig2, fullfile('figures',  'more-noise', 'ab', 'svg', sprintf('ab_f(%.1f).svg', foptions(i))));
    saveas(fig2, fullfile('figures',  'more-noise', 'ab', 'eps', sprintf('ab_f(%.1f).eps', foptions(i))));
    
    saveas(fig3, fullfile('figures',  'more-noise', 'xdif', 'svg', sprintf('xdif_f(%.1f).svg', foptions(i))));
    saveas(fig3, fullfile('figures',  'more-noise', 'xdif', 'eps', sprintf('xdif_f(%.1f).eps', foptions(i))));
    
end
[min_xmse, min_indexx] = min([datas.xmse]);
[min_amse, min_indexa] = min([datas.amse]);
[min_bmse, min_indexb] = min([datas.bmse]);
[min_general_mse, min_index_general] = min([datas.general_mse]);
[max_xmse, max_indexx] = max([datas.xmse]);
[max_amse, max_indexa] = max([datas.amse]);
[max_bmse, max_indexb] = max([datas.bmse]);
[max_general_mse, max_index_general] = max([datas.general_mse]);
X =  ['f = ', num2str(datas(min_indexx).f), ', n0 =  ', num2str(datas(min_indexx).n0), ' for minimum square error for output ',  num2str(min_xmse)]; 
disp(X);
A =  ['f =  ', num2str(datas(min_indexa).f), ', n0 =  ', num2str(datas(min_indexa).n0), ' for minimum square error for a ',  num2str(min_amse)]; 
disp(A);
B =  ['f = ', num2str(datas(min_indexb).f), ', n0 =  ', num2str(datas(min_indexb).n0), ' for minimum square error for b ', num2str(min_bmse)]; 
disp(B);
G =  ['f = ', num2str(datas(min_index_general).f), ', n0 =  ', num2str(datas(min_index_general).n0), ' for general minimum square error ',  num2str(min_general_mse)]; 
disp(G);
fprintf('\n');
Xmax =  ['f = ', num2str(datas(max_indexx).f), ', n0 =  ', num2str(datas(max_indexx).n0), ' for maximum square error for output ',  num2str(max_xmse)]; 
disp(Xmax);
Amax =  ['f =  ', num2str(datas(max_indexa).f), ', n0 =  ', num2str(datas(max_indexa).n0), ' for maximum square error for a ',  num2str(max_amse)]; 
disp(Amax);
Bmax =  ['f = ', num2str(datas(max_indexb).f), ', n0 =  ', num2str(datas(max_indexb).n0), ' for maximum square error for b ',  num2str(max_bmse)]; 
disp(Bmax);
Gmax =  ['f = ', num2str(datas(max_index_general).f), ', n0 =  ', num2str(datas(max_index_general).n0), ' for general maximum square error ', num2str(max_general_mse)]; 
disp(Gmax);
