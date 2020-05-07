function lab1()
    X = csvread('/Users/antontimonin/Desktop/МатСтат/lab_01/Data12.csv');
    X = sort(X);
    
    parametrs(X);
    intervals(X);
    graphs(X); 
end

function parametrs(X)
    X = sort(X);
    Xmin = X(1); fprintf('Mmin = %s\n', num2str(Xmin));
    Mmax = X(end); fprintf('Mmax = %s\n', num2str(Mmax));
    R = Mmax - Xmin; fprintf('R = %s\n', num2str(R));
    mu = expect(X); fprintf('mu = %s\n', num2str(mu));
    sigSqr = populVar(X); fprintf('sigma^2 = %s\n', num2str(sigSqr));
    sqr = unbisVariance(X); fprintf('S^2: %s\n', num2str(sqr));
    m = numSubintervals(length(X)); fprintf('m = %s\n ', num2str(m));
end

function graphs(X)
    hold on;
    f(X, expect(X), ...
         unbisVariance(X), ...
         numSubintervals(length(X)));
    
    figure;
    empiricF(X);
    hold on;
    F(X, expect(X), ...
         unbisVariance(X), ...
         numSubintervals(length(X)));
end

function m = numSubintervals(size)
    m = floor(log2(size) + 2);
end

function m = expect(X)
    n = length(X);
    sum = 0;

    for i = 1:n
        sum = sum + X(i);
    end
    
    m = sum / n;
end

function sigSqr = populVar(X)
    n = length(X);
    sum = 0;

    for i = 1:n
        sum = sum + (X(i))^2;
    end
    
    mu  = expect(X);
    sigSqr = sum / n - mu^2;
end

function sqr = unbisVariance(X)
    sigSqr = populVar(X);
    n = length(X); 

    sqr = n / (n - 1) * sigSqr;
end

function intervals(X)
    m = numSubintervals(length(X));
    
    count = zeros(1, m+2);  
    delta = (X(end) - X(1)) / m;
    
    J = X(1):delta:X(end);
    fprintf('%d\n', X(end));
    J(length(J)+1) = 20;
    
    j = 1;
    n = length(X);
    
    for i = 1:n      
        if (j ~= m)
            if ((not (X(i) >= J(j) && X(i) < J(j+1))))
                j = j + 1;
                fprintf('[%.2f;%.2f)\n', J(j-1), J(j));
            end
        end
        count(j) = count(j) + 1;
        
    end
    fprintf('[%2.2f;%2.2f] -> %d\n', J(m), J(m + 1), count);
    
    Xbuf = count(1:m+2);
    for i = 1:m+2
        Xbuf(i) = count(i) / (n*delta); 
    end
   
    stairs(J, Xbuf), grid;
end

function f(X, MX, DX, m)
    R = X(end) - X(1);
    delta = R/m;
    Sigma = sqrt(DX);
    Xn = (MX - R): delta/50 :(MX + R);
    Xn(length(Xn)+1) = 20;
    Y = normpdf(Xn, MX, Sigma);
    plot(Xn, Y);
end

function F(X, MX, DX, m)
    R = X(end) - X(1);
    delta = R/m;
    Xn = (MX - R): delta :(MX + R);
    Y = 1/2 * (1 + erf((Xn - MX) / sqrt(2*DX))); 
    p2 = plot(Xn, Y,'Color',[.1 .7 .7],'LineWidth',1);
    hold off;
end

function empiricF(X)  
    [yy, xx] = ecdf(X);
    yy(length(yy)+1) = 1;
    xx(length(xx)+1) = 20;
    stairs(xx, yy);
end