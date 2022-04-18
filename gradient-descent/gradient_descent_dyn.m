function [dynamic] = gradient_descent_dyn(t, odex, a, b, am, gamma, u)
  
x = odex(1);
phi1 = odex(2);
phi2 = odex(3);
theta1_hat = odex(4);
theta2_hat = odex(5);


dynamic(1) = - a * x + b * u(t); 
dynamic(2) = - am * phi1 + x; 
dynamic(3) = - am * phi2 + u(t); 
dynamic(4) = gamma * (x - [theta1_hat, theta2_hat] * [phi1; phi2]) * phi1; 
dynamic(5) = gamma * (x - [theta1_hat, theta2_hat] * [phi1; phi2]) * phi2;
dynamic = dynamic';
end

