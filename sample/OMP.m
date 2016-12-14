function [x0] = OMP(A, b, e)
%Orthogonal Matching Pursuit


%get dimension
[m, n] = size(A);

%initial
x0 = zeros(n,1);
r0 = b;
S = [];


k = 0;
OK = 1;

while OK == 1
    k = k+1;
    
    %find jth column s.t. min |Aj x - b|
    
        %don't apply with columns in S
        testA = A;
        testA(:, S) = zeros(m,k-1);
    z = testA(:,1)'*r0;
    if norm(testA(:,1)) > 0
        min =norm ( z/ ( norm(testA(:,1))^2 ) - r0 )^2;
    else
        min = norm(r0)^2;
    end
    j = 1;
    for i = 1:n
        %linear search
        z = testA(:,i)'*r0;
        if norm(testA(:,i)) > 0
            z = ( z/ ( norm(testA(:,i))^2 ) );%z constant
            ai =norm ( testA(:,i)*z - r0 )^2;
        else
            ai = norm(r0)^2;
        end
        if ai < min
            min = ai;
            j = i;
        end
    end
    S(k) = j;
    
    %due to basis may not orthogonal, so need to compute every time
    %compute xk?? Least square?
    
        %sort S first, for convience
        S = sort(S);
    tempA = A(:,S);
    xk = (tempA)'*tempA \ (tempA)'*b;
    
    %update rk
    %fill back to original solution
        [Lm,Ln] = size(S);
    for t = 1:Ln
        %since position is almost same(add one more index)
        %it's ok to direct rewrite
        x0(S(t)) = xk(t);
    end
    r0 = b - A*x0;
    
    %stop
    if norm(r0) < e        
        %terminate
        OK = 0;
    elseif k >=n
        OK = 2;
        disp(OK);
    end
end