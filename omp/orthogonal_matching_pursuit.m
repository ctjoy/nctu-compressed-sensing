function p = orthogonal_matching_pursuit(k, n, N, times)
correct = 0;
for m = 1:times
  % set up real_x
  position = randi([1, N], 1, k);
  real_x = zeros([N, 1]);
  for j = 1:k
    real_x(position(j)) = 1; 
  end

  % init
  phi = randn(n, N) * (2 / n);
  phi = normc(phi);
  b = phi * real_x;
  error_threshold = 0.001;

  x = zeros([N, 1]);
  r = b;
  s = [];
  error = 10000;

  % OMP
  while error > error_threshold 
    max_lambda = -100; 
    j = 0; 
    for i = 1:N 
      if sum(ismember(s, i)) == 0 
        lambda = abs(transpose(r) * phi(:, i)); 
        if lambda > max_lambda 
          max_lambda = lambda; 
          j = i; 
        end 
      end 
    end 
    s(length(s) + 1) = j; 
    phi_lambda = phi(:, s); 
    x_t = phi_lambda \ b; 
    a_t = phi_lambda * x_t; 
    r_t = b - a_t; 
    error = transpose(r_t) * r_t; 
  end 
  for i = 1:length(s) 
    x(s(i)) = 1; 
  end 
  if isequal(int8(x), real_x) 
    correct = correct + 1; 
  end 
end 
p = correct / times; 
end
