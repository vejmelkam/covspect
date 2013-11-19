function RMSE = enkf2dx_rmse(X,Y,Z)
    [n,~,m,r] = size(X);
    
    X = reshape(X,n*n,m,r);
    Y = reshape(Y,n*n,m,r);
    Z = reshape(Z,n*n,m,r);
    
    RMSE = zeros(2,m,r);
    RMSE(1,:,:) = sqrt(mean((X-Y).^2,1));
    RMSE(2,:,:) = sqrt(mean((Z-Y).^2,1));
end