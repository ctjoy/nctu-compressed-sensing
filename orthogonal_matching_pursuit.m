function p = orthogonal_matching_pursuit(k, n, N, times)
correct = 0;
phi = randn(n, N) * (1 / sqrt(n));
phi = normc(phi);

for m = 1:times
    position = randi([1, N], 1, k);
    real_x = zeros([N, 1]);
    real_x(position) = 1; 

    b = phi * real_x;
    error_threshold = 0.001;

    x = zeros([N, 1]);
    r = b;
    s = [];
    phi_b = phi;

    while norm(r) > error_threshold 
        [~, argmax] = max(abs(transpose(r) * phi_b));

        phi_b(:, argmax) = zeros(n, 1);
        s(length(s) + 1) = argmax;
        s = sort(s);
        phi_lambda = phi(:, s);
        x_t = phi_lambda \ b;
        a_t = phi_lambda * x_t;
        r = b - a_t;
    end
    
    x(s) = 1;
    if norm(x - real_x) < 1
        correct = correct + 1;
    end
end
p = correct / times;
disp(p);
end