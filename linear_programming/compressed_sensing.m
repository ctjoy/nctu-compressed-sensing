N = 100;

bad_coin = zeros([5, 40]);
for i = 1:5
    for j = 1:40
        bad_coin(i, j) = probability_get_right_x(i, j, N, 1000);
    end
end

figure
plot(transpose(bad_coin))
