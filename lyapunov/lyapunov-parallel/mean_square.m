function [mse] = mean_square(x, xhat)
sum = 0;
for i = 1:length(x)
    
    sum = sum + (x(i) - xhat(i))^2;

end
    mse = sum / length(x);
end

