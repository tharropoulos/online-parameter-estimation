function [data,odex] = gradient_descent(t, initialconditions,a, b, am, gamma, u)
odex = struct('x', initialconditions(1), 'phi1', initialconditions(2), 'phi2', initialconditions(3), 'theta1_hat', initialconditions(4), 'theta2_hat', initialconditions(5));
as = a*ones(length(t),1);
bs = b*ones(length(t),1);

[~,res] = ode45(@(t,odex) gradient_descent_dyn(t, odex, a, b, am, gamma, u), t, initialconditions);

data.x = res(:,1);
data.phi = [res(:,2), res(:,3)];
data.theta_hat = [res(:,4), res(:,5)];
data.x_hat = data.theta_hat(:,1) .* data.phi(:,1) + data.theta_hat(:,2) .* data.phi(:,2) ;
data.a_hat = am - res(:,4);
data.b_hat = data.theta_hat(:,2);
data.xmse = immse(data.x, data.x_hat); 
data.amse = immse(as, data.a_hat);
data.bmse = immse(bs, data.b_hat);
data.general_mse = data.xmse*data.amse*data.bmse;

end

