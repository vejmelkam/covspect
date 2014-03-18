%   Test of enkf3dx.m
nx = 64;
ny = 32;
nz = 128;
nv = 5;
N = 5;
%   Generating ensemble.
X = randn(nx,ny,nz,nv,N);
D = randn(nx,ny,nz);

%%
XA = squeeze(enkf3dx(X,D,1,1,@(n) fft_matrix(n)))   ;

%ensemble mean - observed variavble
EM = mean(reshape(XA(:,:,:,1,:),nx*ny*nz,N),2);

Y = reshape(D,nx*ny*nz,1);
% forecast error
FE = mean(reshape(X(:,:,:,1,:),nx*ny*nz,N),2)-reshape(Y,nx*ny*nz,1); 

fprintf('forecat errror: \n \t ME: %f \n \t MAE: %f \n \t RMSE: %f \n',mean(FE),mean(abs(FE)),mean(FE.^2));
fprintf('3d assimilation: \n \t ME: %f \n \t MAE: %f \n \t RMSE: %f \n',mean(EM-Y),mean(abs(EM-Y)),mean((EM-Y).^2));
