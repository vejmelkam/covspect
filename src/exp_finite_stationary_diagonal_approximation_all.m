
%% Explanation
%
%  This experiment looks at diagonal approximations of various stationary
%  covariance matrices (DISREGARDING boundary conditions) in various
%  spaces, such as the Fourier, DST, ... or wavelet spaces in 1D.
%
%

%% Parameters

pn = 256;                     % dimensionality of spaces (no. of grid points)
pN = 1:5;                     % ensemble sizes
iters = 10;                   % number of iterations with each configuration
palpha = logspace(-2, 1, 10); % smoothness of covariance function
pmethods = { 'DST', 'DCT', 'FFT', 'Coiflet' };  % use the following xforms
pxf_funcs = {@dst_matrix, @dct_matrix, @fft_matrix, @wav_coi_matrix };

pF = {};
for i=1:length(pmethods)
    f = pxf_funcs{i};
    pF{i} = f(pn);
end

results = zeros(length(palpha), length(pN), length(pmethods), iters, 2);

for alpha_ndx=1:length(palpha)
    alpha = palpha(alpha_ndx);
    fprintf('Running experiment for alpha = %g', alpha);
    cs = exp(-(0:pn-1)*alpha);
    C = make_finite_cov_matrix_from_cs(cs,pn);
    if any(eig(C) <= 0)
        error('Matrix not positive definite for alpha=%g', alpha);
    end
    for N_ndx=1:length(pN)
        N = pN(N_ndx);
        for iter=1:iters
            % Y is an N(0,I)-distributed ensemble (elements in column)
            Y = randn(pn,N);
            for meth_id=1:length(pmethods)
                % matrix transforming grid space to spectral/wavelet space
                F = pF{meth_id};
                C_F = F*C*F';
                norm_C_F = norm(C_F, 'fro');

                % compute symmetric square root
                C_F_05 = sqrtm(C_F);

                % generate ensemble
                X = C_F_05 * Y;

                % compute sample covariance estimate (already in spectral
                % space)
                C_FN = 1/N*X*X';

                % diagonalize
                D_FN = diag(diag(C_FN));

                % compute errors
                results(alpha_ndx, N_ndx, meth_id, iter, 1) = norm(C_FN - C_F, 'fro') / norm_C_F;
                results(alpha_ndx, N_ndx, meth_id, iter, 2) = norm(D_FN - C_F, 'fro') / norm_C_F;
            end
        end
    end
end
