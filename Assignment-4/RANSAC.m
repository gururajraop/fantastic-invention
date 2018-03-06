function [f1_new] = RANSAC(t, f1, f2)
    n = randi(20);
    n = 1;
    
    perm = randperm(size(t, 2));
    perm_n = randi(size(t, 2));
    perm_n = 4;
    p = perm(1:perm_n);
    best_inliers = 0;
    inliers = [];
    best_x = [1 1 0; 1 1 0];
    
    for i = 1:n
    
        A = zeros(2*perm_n, 6);
        b = zeros(2*perm_n, 1);
        f2_new = zeros(size(f1));
        
        for p_i = 1:perm_n
            A(2*p_i-1:2*p_i, :) = [f1(t(1, p_i), 1) f1(t(1, p_i), 2) 0 0 1 0; 0 0 f1(t(1, p_i), 1) f1(t(1, p_i), 2) 0 1];
            b(2*p_i-1:2*p_i) = [f2(t(2, p_i), 1); f2(t(2, p_i), 2)];
        end
        
        x = pinv(A)*b;
        
        inliers = 0;
        for j = 1:size(t, 2)
             f2_new(1:2, j) = reshape(x(1:4), 2, 2) * f1(1:2, t(1,j)) + reshape(x(5:6), 2, 1);
             diff = abs(f2(1:2, j) - f2_new(1:2, j));
             if diff(1) < 10 && diff(2) < 10
                 inliers = inliers + 1;
             end
        end
        
        if inliers > best_inliers
            best_x = x;
        end
    end
    
    f1_new = zeros(size(f1));
    for j = 1:size(f1, 2)
         f1_new(1:2, j) = reshape(best_x(1:4), 2, 2) * f1(1:2, t(1,j)) + reshape(best_x(5:6), 2, 1);    
    end
    
    
end