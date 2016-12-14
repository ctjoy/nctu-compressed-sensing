%compress sencing N( 0, 1/n )
%fix x, change phi 1000 times
%now with test, weight is int
%omp suit for sencing matrix N(0,1/N), not suit for (0,1) matrix (possibly smae columns)

clear;
hold off;


    

N = 100;
q = 0.35; %fraction of eqs
n = q*N; %max times of weight

error = 0.000001;


%experiment t times
    times = 1000;

%xBar = zeros(100, 1);
index = zeros(1, 5);
success = zeros(5, (n-5+1) );% 5 * 35-5+1

%Since zero close to sparse vector
    xInit = zeros(N,1);

%prepare one norm minization
    A = eye(N);

    bTest = zeros(N, 1);
    
%set x 
    x = zeros(N,1);
    
for k=1:5 % 1~5 counterfeit
    %set sparse x
        index(k) = randi( N );
        while x(index(k)) ~= 0
            index(k) = randi( N );
        end
            
        %x( index(k) ) = 2*rand-1;
        x( index(k) ) = 1 - round(rand())*2;
    %end set
    
    for j=1:times %1000times random phi
        Phi = rand(n,N);
        %Phi(Phi>0.5) = 1;
        %Phi(Phi<=0.5) = 0;
        
        
        
        for i=1:(n-5+1)%each new phi, do 5~35
            PhiTemp = Phi( 1:(i+4) , : ); % i+4 is weight
           
            %prepare b first by Phi*x
                b = PhiTemp*x;
                
                
                
            xBar = OMP(PhiTemp, b, error);
            
            %check component if it is right
            %{
            fit = 1;
            for p=1:k
                if 
                    fit = 0;
                    break;
                end
            end
            %}
            
            %{
            if abs( xBar( index(k) ) - x( index(k) ) ) < error
                    success(k,i) = success(k,i) + 1;
                    %fprintf('yes');
            end
            %}
            
            right = 1;
            for t=1:k
                if abs( xBar( index(t) ) - x( index(t) ) ) >= error
                    right = 0;
                end
            end
            %disp(right);%
            if right == 1
                success(k,i) = success(k,i) + 1;
            end
           
           
        end
        
        
        
        
        
        
        
        
    end%end j=1:1000
    
    
    
end

successR = success/times;

%dipplay weight -> probability
    xAxis = 5:n;
    y = successR;
    
    hold on;
    
    plot(xAxis, y(1, :), '-dk');
    plot(xAxis, y(2, :), '-vg');
    plot(xAxis, y(3, :), '-oy');
    plot(xAxis, y(4, :), '-*m');
    plot(xAxis, y(5, :), '-^r');
    
    legend('1 bad coin', '2 bad coins', '3 bad coins', '4 bad coins', '5 bad coins', 4);
    
    hold off;
   
%end display
