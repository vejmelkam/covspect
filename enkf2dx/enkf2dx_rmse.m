function RMSE = enkf2dx_rmse(X,Y,Z)
    [nx,ny,m,r] = size(X);
    
    X = reshape(X,nx*ny,m,r);
    Y = reshape(Y,nx*ny,m,r);
    Z = reshape(Z,nx*ny,m,r);
    
    RMSE = zeros(2,m,r);
    RMSE(1,:,:) = sqrt(mean((X-Y).^2,1));
    RMSE(2,:,:) = sqrt(mean((Z-Y).^2,1));
end