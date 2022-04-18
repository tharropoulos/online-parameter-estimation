function [data,odex] = lyapunov_par(t, initialconditions,a, b, gamma1,gamma2, u, n)
odex = struct('x', initialconditions(1), 'theta1_hat', initialconditions(2), 'theta2_hat', initialconditions(3), 'x_hat', initialconditions(4));

[~,res] = ode45(@(t,odex) lyapunov_par_dyn(t, odex, a, b, gamma1,gamma2, u, n), t, initialconditions);

data.x = res(:,1);
data.theta_hat = [res(:,2), res(:,3)];
data.x_hat = res(:,4);
data.a_hat = data.theta_hat(:,1);
data.b_hat = data.theta_hat(:,2);


end

