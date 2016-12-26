function p = linear_programming(k, n, N, times)
phi = randi([0, 1], n, N);
correct = 0;
for m = 1:times
    % init
    position = randi([1, N], 1, k);
    real_x = zeros([N, 1]);
    real_x(position) = 1; 

    % get b
    b = phi * real_x;

    % know phi and b, use linear programming get x
    f = ones([N, 1]);
    lb = zeros([N, 1]);
    ub = ones([N, 1]);
    x = linprog(f,phi,b,phi,b,lb,ub);
    if isequal(int8(x), real_x)
        correct = correct + 1;
    end
end
p = correct / times;
disp(p);
end
