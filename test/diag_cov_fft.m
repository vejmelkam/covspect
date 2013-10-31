
%% parameters of the simulation
n = 4;

%% construct the diagonal covariance in Fourier space (C_F)
d = 0.0;   % dropoff exponential factor
U_C = diag((1:n).^(-d));
C_F = U_C'*U_C;

%% construct the forward FFT mapping
F = make_fft(n);

% C_F = F * C * F' and so C = F' * C_F * F, since F' = F^-1

%% construct covariance in grid space
C = F' * C_F * F;

%% display on image
subplot(121);
imagesc(real(C));
colorbar();
caxis([0 1]);
subplot(122);
imagesc(imag(C));
colorbar();
caxis([0 1]);
