function [data,odex] = lyapunov_par_2D(t, initialconditions,A, B, gamma1,gamma2, u)
odex = struct('x1', initialconditions(1), 'x2', initialconditions(2), 'x1_hat', initialconditions(3), 'x2_hat', initialconditions(4), 'a11_hat', initialconditions(5), 'a12_hat', initialconditions(6), 'a21_hat', initialconditions(7), 'a22_hat', initialconditions(8), 'b1_hat', initialconditions(9), 'b2_hat', initialconditions(10));
as = {A(1,1)*ones(length(t),1), A(1,2)*ones(length(t),1);  A(2,1)*ones(length(t),1), A(2,2)*ones(length(t),1)};
bs = {B(1)*ones(length(t),1); B(2)*ones(length(t),1)};

% a11s = A(1,1)*ones(length(t),1);
% a12s = A(1,2)*ones(length(t),1);
% a21s = A(2,1)*ones(length(t),1);
% a22s = A(2,2)*ones(length(t),1);
% b1s = ;
% b2s = B(2)*ones(length(t),1);

[~,res] = ode45(@(t,odex) lyapunov_par_2D_dyn(t, odex, A, B, gamma1,gamma2, u), t, initialconditions);

data.x = [res(:,1), res(:,2)];
data.x_hat = [res(:,3), res(:,4)];
data.A_hat = {res(:,5), res(:,6); res(:,7), res(:,8)};
data.B_hat = {res(:,9); res(:,10)};

data.xmse = {immse(data.x(:,1), data.x_hat(:,1)); immse(data.x(:,2), data.x_hat(:,2))}; 
data.amse = {immse(cell2mat(as(1,1)), cell2mat(data.A_hat(1,1))), immse(cell2mat(as(1,2)), cell2mat(data.A_hat(1,2))); immse(cell2mat(as(2,1)), cell2mat(data.A_hat(2,1))), immse(cell2mat(as(2,2)), cell2mat(data.A_hat(2,2))) };
data.bmse = {immse(cell2mat(bs(1)), cell2mat(data.B_hat(1))); immse(cell2mat(bs(2)), cell2mat(data.B_hat(2)))};

% data.general_mse = data.xmse*data.amse*data.bmse;
end

