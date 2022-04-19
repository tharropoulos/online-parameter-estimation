function [data, odex] = lyapunov_mixed(t, initialconditions,a, b, gamma1,gamma2, theta_m, u, n)
odex = struct('x', initialconditions(1), 'theta1_hat', initialconditions(2), 'theta2_hat', initialconditions(3), 'x_hat', initialconditions(4));

as = a*ones(length(t),1);
bs = b*ones(length(t),1);

[~,res] = ode45(@(t,odex) lyapunov_mixed_dyn(t, odex, a, b, gamma1,gamma2, theta_m, u, n), t, initialconditions);
data.x = res(:,1);
data.theta_hat = [res(:,2),res(:,3)];
data.x_hat = res(:,4);
data.a_hat = data.theta_hat(:,1);
data.b_hat = data.theta_hat(:,2);
data.xmse = immse(data.x, data.x_hat); 
data.amse = immse(as, data.a_hat);
data.bmse = immse(bs, data.b_hat);
data.general_mse = data.xmse*data.amse*data.bmse;
end

