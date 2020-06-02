function lab2()
     X = [7.76,5.96,4.58,6.13,5.05,6.40,7.46,5.55,5.01,3.79,7.65,...
         8.87,5.94,7.25,6.76,6.92,6.68,4.89,7.47,6.53, 6.76,6.96,...
         6.58,7.92,8.47,6.27,8.05,5.24,5.60,6.69,7.55,6.02, 7.34,...
         6.81,7.22,6.39,6.40,8.28,5.39,5.68,6.71,7.89,5.69, 5.18,...
         7.84,7.18,7.54,6.04,4.58,6.82,4.45, 6.75,5.28,7.42,6.88,...
         7.10,5.24,9.12,7.37,5.50,5.52,6.34,5.31, 7.71,6.88,6.45,...
         7.51,6.21,7.44, 6.15,6.25,5.59,6.68,6.52,4.03,5.35,6.53,...
         3.68,5.91,6.68,6.18,7.80, 7.17,7.31,4.48,5.69,7.11,6.87,...
         6.14,4.73,6.60,5.61,7.32,6.75,6.28, 6.41,7.31,6.68,7.26,...
         7.94,7.67, 4.72,6.01,5.79,7.38,5.98,5.36,6.43,7.25,5.54,...
         6.66, 6.47, 6.84,6.13, 6.21, 5.52, 6.33,7.55, 6.24,7.84];
    
    N = 4:120;
    gamma = 0.9;
    alpha = (1 - gamma) / 2;

    math_exp = mean(X);
    variance = var(X); 

    math_exp_array = [];
    variance_array = [];

    for i = N
        math_exp_array = [math_exp_array, mean(X(1:i))];
        variance_array = [variance_array,  var(X(1:i))];
    end
 
    figure
    plot([N(1), N(end)], [math_exp, math_exp], 'm');
    hold on;
    plot(N, math_exp_array, 'r');
    
    tmp_math_exp = sqrt(variance_array./N).*tinv(1 - alpha, N - 1);
    math_exp_low = math_exp_array - tmp_math_exp;
    math_exp_high = math_exp_array + tmp_math_exp;
    
    plot(N, math_exp_low, 'g');
    plot(N, math_exp_high, 'b');
    grid on; hold off;

    figure
    plot([N(1), N(end)], [variance, variance], 'm');
    hold on;
    plot(N, variance_array, 'r');
    
    tmp_variance = variance_array.*(N - 1);
    variance_low = tmp_variance./chi2inv(1 - alpha, N - 1);
    variance_high = tmp_variance./chi2inv(alpha, N - 1);
    
    plot(N, variance_low, 'g');
    plot(N, variance_high, 'b');
    grid on; hold off;
    
    fprintf('math_exp = %.2f\n', math_exp); 
    fprintf('variance = %.2f\n\n', variance);
    
    fprintf('low  math expectation = %.2f\n', math_exp_low(end));
    fprintf('high math exprectation = %.2f\n', math_exp_high(end));
    
    fprintf('low  variance = %.2f\n', variance_low(end));
    fprintf('high variance = %.2f\n', variance_high(end));
end
