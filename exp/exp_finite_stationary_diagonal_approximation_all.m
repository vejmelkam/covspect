
%% Explanation
%
%  This experiment looks at diagonal approximations of various stationary
%  covariance matrices (DISREGARDING boundary conditions) in various
%  spaces, such as the Fourier, DST, ... or wavelet spaces in 1D.
%
%

%% Parameters

pn = 256;                     % dimensionality of spaces (no. of grid points)
pN = 1:2:10;                  % ensemble sizes
iters = 10;                   % number of iterations with each configuration
palpha = logspace(-2, 1, 10); % smoothness of covariance function

% use the following methods for approximating sample covariance
% NOTE: 'Sample' MUST be first!
pmethods = { 'Sample', 'DST', 'DCT', 'FFT', 'Coiflet' };  % use the following xforms
pxf_funcs = {@(n) error('this should not be called'), @dst_matrix, @dct_matrix, @fft_matrix, @wav_coi_matrix };

pF = {};
for i=1:length(pmethods)
    f = pxf_funcs{i};
    pF{i} = f(pn);
end

results = zeros(length(palpha), length(pN), length(pmethods), iters);

for alpha_ndx=1:length(palpha)
    alpha = palpha(alpha_ndx);
    fprintf('Running experiment for alpha = %g\n', alpha);
    cs = exp(-(0:pn-1)/alpha);
    C = make_finite_cov_matrix_from_cs(cs,pn);
    if any(eig(C) <= 0)
        error('Matrix not positive definite for alpha=%g', alpha);
    end
    C_05 = sqrtm(C);
    for N_ndx=1:length(pN)
        N = pN(N_ndx);
        for iter=1:iters
            % Y is an N(0,I)-distributed ensemble (elements in column)
            Y = randn(pn,N);
            X = C_05*Y;
            C_N = 1/N*(X*X');
            results(alpha_ndx, N_ndx, 1, iter, 1) = norm(C_N - C, 'fro') / norm(C, 'fro');
            for meth_id=2:length(pmethods)
                % matrix transforming grid space to spectral/wavelet space
                F = pF{meth_id};
                C_F = F*C*F';
                norm_C_F = norm(C_F, 'fro');
                
                % sample covariance in spectral/wavelet space
                C_FN = F*C_N*F;

                % diagonalize
                D_FN = diag(diag(C_FN));

                % compute errors
                results(alpha_ndx, N_ndx, meth_id, iter) = norm(D_FN - C_F, 'fro') / norm_C_F;
            end
        end
    end
end
