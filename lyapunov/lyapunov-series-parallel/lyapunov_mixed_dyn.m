function [odedx] = lyapunov_mixed_dyn(t,odex,gamma1, gamma2, theta_m u, n)
x = odex(1);
theta1_hat = odex(2);
theta2_hat = odex(3);
x_hat = odex(4);

error = x - x_hat + n(t);

odedx(1) = -a * x + b *u(t);
odedx(2) = -gamma1 * error * x;
odedx(3) = gamma2 * error * u(t);
odedx(4) = -theta1_hat * x + theta2_hat * u(t) + theta_m *error;
odedx = odedx';


end

