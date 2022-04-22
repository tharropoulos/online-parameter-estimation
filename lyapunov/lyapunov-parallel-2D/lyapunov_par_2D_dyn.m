function [dynamic] = lyapunov_par_2D_dyn(t, odex, A, B, gamma1,gamma2, u)

x1 = odex(1);
x2 = odex(2);
x1_hat = odex(3);
x2_hat = odex(4);
a11_hat = odex(5);
a12_hat = odex(6);
a21_hat = odex(7);
a22_hat = odex(8);
b1_hat = odex(9);
b2_hat = odex(10);



error1 = x1 - x1_hat;
error2 = x2 - x2_hat;


dynamic(1) = A(1,1) * x1 +A(1,2)*x2 + B(1) * u(t);
dynamic(2) = A(2,1) * x1 + A(2,2) * x2 + B(2) * u(t);
dynamic(3) = a11_hat * x1_hat + a12_hat * x2_hat + b1_hat * u(t);
dynamic(4) = a21_hat * x1_hat + a22_hat * x2_hat + b2_hat * u(t);
dynamic(5) = gamma1 * x1_hat * error1;
dynamic(6) = gamma1 * x2_hat * error1;
dynamic(7) = gamma1 * x1_hat * error2;
dynamic(8) = gamma1 * x2_hat * error2;
dynamic(9) = gamma2 * u(t) * error1;
dynamic(10) = gamma2 * u(t) * error2;
dynamic = dynamic';

end

