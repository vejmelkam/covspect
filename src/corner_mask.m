

function M = corner_mask(n, m)

    M = eye(n);
    M(1:m,1:m) = 1;
    
end