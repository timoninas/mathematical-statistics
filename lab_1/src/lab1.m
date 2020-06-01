function lab1()

    X = [7.76,5.96,4.58,6.13,5.05,6.40,7.46,5.55,5.01,3.79, ...
         7.65,8.87,5.94,7.25,6.76,6.92,6.68,4.89,7.47,6.53, ...
         6.76,6.96,6.58,7.92,8.47,6.27,8.05,5.24,5.60,6.69, ...
         7.55,6.02,7.34,6.81,7.22,6.39,6.40,8.28,5.39,5.68, ...
         6.71,7.89,5.69,5.18,7.84,7.18,7.54,6.04,4.58,6.82, ...
         4.45,6.75,5.28,7.42,6.88,7.10,5.24,9.12,7.37,5.50, ...
         5.52,6.34,5.31,7.71,6.88,6.45,7.51,6.21,7.44,6.15, ...
         6.25,5.59,6.68,6.52,4.03,5.35,6.53,3.68,5.91,6.68, ...
         6.18,7.80,7.17,7.31,4.48,5.69,7.11,6.87,6.14,4.73, ...
         6.60,5.61,7.32,6.75,6.28,6.41,7.31,6.68,7.26,7.94, ...
         7.67,4.72,6.01,5.79,7.38,5.98,5.36,6.43,7.25,5.54, ...
         6.66,6.47,6.84,6.13,6.21,5.52,6.33,7.55,6.24,7.84];

    X = sort(X);
    
%     а)
    Xmin = X(1);
    fprintf('Xmin = %.3f\n', Xmin);
    Xmax = X(end);
    fprintf('Xmax = %.3f\n', Xmax);
    
%     б)
    R = Xmax - Xmin;
    fprintf('R = %.3f\n', R);
    
%     в)
    MX = expectation(X);
    fprintf('MX= %.3f\n', MX);
    DX = variance(X);
    fprintf('DX= %.3f\n', DX);
    
%     г)
    m = group(X);
    fprintf('m=%d\n', m);
    delta=R/m;
    fprintf('delta = %.3f\n', delta);
    J = Xmin : delta : Xmax;
    n = length(J);
    for i = 1:(n - 2)
        fprintf('[%.3f; %.3f)\n', J(i), J(i + 1));
    end
    fprintf('[%.3f; %.3f]\n', J(n - 1), J(n));
    
    sigma = sqrt(DX);
    Xn = (MX - R) : delta / 50 :(MX + R);
    
%     д)
    f(X, Xn, MX, sigma);
    
%     е)
    F(X, Xn, MX, sigma);
    
end

function MX = expectation(X)
    MX = mean(X);
end

function DX = variance(X)
    DX = var(X);
end

function m = group(X)
    m = floor(log2(length(X))) + 2;
end

function F(X, Xn, MX, sigma)
    figure;
    Ycdf = 1/2 * (1 + erf((Xn - MX) / sqrt(2) * sigma));
    ecdf (X);
    hold on;
    plot(Xn, Ycdf, 'r');
    hold off ;
end

function f(X, Xn, MX, sigma)
    Ypdf = normpdf(Xn, MX, sigma);
    histogram (X, 'normalization' , 'pdf' ) ;
    hold on;
    plt = plot(Xn, Ypdf, 'r');
    plt.LineWidth = 1;
end
