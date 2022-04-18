function [dynamic] = lyapunov_par_dyn(t, odex, a, b, gamma1,gamma2, u, n)
x = odex(1);
theta1_hat = odex(2);
theta2_hat = odex(3);
x_hat = odex(4);


error = x - x_hat + n(t);

dynamic(1) = -a * x + b *u(t);
dynamic(2) = -gamma1 * error * x_hat;
dynamic(3) = gamma2 * error * u(t);
dynamic(4) = -theta1_hat * x_hat + theta2_hat * u(t);
dynamic = dynamic';

end

