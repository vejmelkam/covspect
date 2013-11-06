
%% Explanation
%
%  This experiment looks at diagonal approximations of various stationary
%  covariance matrices (DISREGARDING boundary conditions) in various
%  spaces, such as the Fourier, DST, ... or wavelet spaces in 1D.
%
%
clear;

%% Parameters

pn = 512;                     % dimensionality of spaces (no. of grid points)
pN = 1:4:41;                  % ensemble sizes
iters = 20;                   % number of iterations with each configuration
cs_parms = [0.01 0.05 0.1 0.5 1];    % parameters fo cs
cs_func = @make_cs_exp_alpha; % function, which create covariance operator vector

% use the following methods for approximating sample covariance
pmethods = { 'DST', 'DCT', 'FFT', 'Coiflet' };  % use the following xforms
pxf_funcs = { @dst_matrix, @dct_matrix, @fft_matrix, @wav_coi_matrix };

pF = {};
for i=1:length(pmethods)
    f = pxf_funcs{i};
    pF{i} = f(pn);
end

%   errors in each simulation
%   last dimension stands for error using:
%   1 - whole sample covariance 
%   2 - diagonal elements of sample covariance
results = zeros(length(cs_parms), length(pN), length(pmethods), iters, 2);

for cs_ndx=1:length(cs_parms)
    cs_par = cs_parms(cs_ndx);
    fprintf('Running experiment for cs_par = %g\n', cs_par);
    cs = cs_func(cs_par);
    cs = cs(1:min(length(cs),pn));
    C = make_finite_cov_matrix_from_cs(cs,pn);
    if any(eig(C) <= 0)
        error('Matrix not positive definite for cs_par=%g', cs_par);
    end
    norm_C = norm(C, 'fro');
    [V,D] = eig(C);
    C_05 = V*D.^0.5*V';
    for N_ndx=1:length(pN)
        N = pN(N_ndx);
        for iter=1:iters
            % Y is an N(0,I)-distributed ensemble (elements in column)
            Y = randn(pn,N);
            X = C_05*Y;
            C_N = 1/N*(X*X');
            
            % manually compute the sample covariance approximation and
            % store it with all of the methods (unchanged by transforms)
            results(cs_ndx, N_ndx, :, iter, 1) = norm(C_N - C, 'fro') / norm_C;
            
            for meth_id=1:length(pmethods)
                % matrix transforming grid space to spectral/wavelet space
                F = pF{meth_id};
                C_F = F*C*F';
                
                % sample covariance in spectral/wavelet space
                C_FN = F*C_N*F;

                % diagonalize
                D_FN = diag(diag(C_FN));

                % compute errors
                results(cs_ndx, N_ndx, meth_id, iter, 2) = norm(D_FN - C_F, 'fro') / norm_C;
            end
        end
    end
end
