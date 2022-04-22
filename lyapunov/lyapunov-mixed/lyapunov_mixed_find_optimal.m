
close all;

tspan = 0:0.001:30;

gamma1_options = [0.1, 0.3, 0.5, 1, 4, 5, 10, 30];
gamma2_options = [0.1, 0.4, 0.7, 2, 5, 8, 24, 40];
theta_m_options = [0.5, 1, 2, 4, 6, 12, 24, 48];

initialconditions = zeros(1,4);

a = 1.5;
b = 2;

n_0 = 1.5;
f = 20;

u = @(t) 3 * cos(2*t);
n = @(t) n_0 * sin(2*pi*f*t);

ctr = 1;

for i=1:length(theta_m_options)
    for j=1:length(gamma1_options)
        for k = 1:length(gamma2_options)
            [data, odex] = lyapunov_mixed(tspan, initialconditions, a, b, gamma1_options(j), gamma2_options(k), theta_m_options(i), u, n);
            
             datas(ctr).xmse = data.xmse;
             datas(ctr).amse = data.amse;
             datas(ctr).bmse = data.bmse;
             datas(ctr).general_mse = data.general_mse;
             datas(ctr).gamma1 = gamma1_options(j);
             datas(ctr).gamma2 = gamma2_options(k);
             datas(ctr).theta_m = theta_m_options(i);
             datas(ctr).x = data.x;
             datas(ctr).x_hat = data.x_hat;
             datas(ctr).a_hat = data.a_hat;
             datas(ctr).b_hat = data.b_hat;

        
             ctr = ctr+1;
        end
    end
end
[min_xmse, min_indexx] = min([datas.xmse]);
[min_amse, min_indexa] = min([datas.amse]);
[min_bmse, min_indexb] = min([datas.bmse]);
[min_general_mse, min_index_general] = min([datas.general_mse]);
[max_xmse, max_indexx] = max([datas.xmse]);
[max_amse, max_indexa] = max([datas.amse]);
[max_bmse, max_indexb] = max([datas.bmse]);
[max_general_mse, max_index_general] = max([datas.general_mse]);


Xmin = ['gamma1 = ', num2str(datas(min_indexx).gamma1), ', gamma 2 = ', num2str(datas(min_indexx).gamma2), ', theta_m = ', num2str(datas(min_indexx).theta_m), ' for minimum square error for output ', num2str(min_xmse)];
disp(Xmin);

Amin = ['gamma1 = ', num2str(datas(min_indexa).gamma1), ', gamma 2 = ', num2str(datas(min_indexa).gamma2), ', theta_m = ', num2str(datas(min_indexa).theta_m), ' for minimum square error for a ', num2str(min_amse)];
disp(Amin);

Bmin = ['gamma1 = ', num2str(datas(min_indexb).gamma1), ', gamma 2 = ', num2str(datas(min_indexb).gamma2), ', theta_m = ', num2str(datas(min_indexb).theta_m), ' for minimum square error for b ', num2str(min_bmse)];
disp(Bmin);

Gmin = ['gamma1 = ', num2str(datas(min_index_general).gamma1), ', gamma 2 = ', num2str(datas(min_index_general).gamma2), ', theta_m = ', num2str(datas(min_index_general).theta_m), ' for minimum general square error for ', num2str(min_general_mse)];
disp(Gmin);

fprintf('\n');

Xmax = ['gamma1 = ', num2str(datas(max_indexx).gamma1), ', gamma 2 = ', num2str(datas(max_indexx).gamma2), ', theta_m = ', num2str(datas(max_indexx).theta_m), ' for maximum square error for output ', num2str(max_xmse)];
disp(Xmax);

Amax = ['gamma1 = ', num2str(datas(max_indexa).gamma1), ', gamma 2 = ', num2str(datas(max_indexa).gamma2), ', theta_m = ', num2str(datas(max_indexa).theta_m), ' for maximum square error for a ', num2str(max_amse)];
disp(Amax);

Bmax = ['gamma1 = ', num2str(datas(max_indexb).gamma1), ', gamma 2 = ', num2str(datas(max_indexb).gamma2), ', theta_m = ', num2str(datas(max_indexb).theta_m), ' for maximum square error for b ', num2str(max_bmse)];
disp(Bmax);

Gmax = ['gamma1 = ', num2str(datas(max_index_general).gamma1), ', gamma 2 = ', num2str(datas(max_index_general).gamma2), ', theta_m = ', num2str(datas(max_index_general).theta_m), ' for maximum general square error ', num2str(max_general_mse)];
disp(Gmax);