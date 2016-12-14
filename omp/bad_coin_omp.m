N = 100;

bad_coin = zeros([5, 40]);
for i = 1:5
      for j = 1:40
                tic
                bad_coin(i, j) = orthogonal_matching_pursuit(i, j, N, 1000);
                toc
              end
            end

            figure
            plot(transpose(bad_coin))
