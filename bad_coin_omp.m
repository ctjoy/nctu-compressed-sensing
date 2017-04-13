N = 100;

bad_coin = zeros([5, 40]);
tic
for i = 1:5
    for j = 1:40        
        disp(i);
        disp(j);
        bad_coin(i, j) = orthogonal_matching_pursuit(i, j, N, 1000);        
    end
end
toc

figure
x_axis = 1:40;
plot(x_axis, bad_coin(1, :), '-o', x_axis, bad_coin(2,:), '-o', x_axis, bad_coin(3,:), '-o', x_axis, bad_coin(4,:), '-o', x_axis, bad_coin(5,:), '-o');

legend('1 bad coin', '2 bad coin', '3 bad coin', '4 bad coin', '5 bad coin');
title('Orthogonal Matching Pursuit');
xlabel('Number of Weighings');
ylabel('Probability of Success');
