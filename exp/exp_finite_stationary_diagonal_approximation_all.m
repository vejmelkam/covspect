
%% Explanation
%
%  This experiment looks at diagonal approximations of various stationary
%  covariance matrices (DISREGARDING boundary conditions) in various
%  spaces, such as the Fourier, DST, ... or wavelet spaces in 1D.
%
%

% use the following methods for approximating sample covariance
pmethods = { 'DST', 'DCT', 'FFT', 'Coiflet', 'Analytical (stat)' };  % use the following xforms
pxf_funcs = { @dst_matrix, @dct_matrix, @fft_matrix, @(n) wav_matrix(n,4,'Beylkin',1) };

%   errors in each simulation
%   last dimension stands for error using:
%   1 - whole sample covariance 
%   2 - diagonal elements of sample covariance
results = zeros(length(pn), length(cs_parms), length(pN), length(pmethods), iters, 4);

for n_ndx=1:length(pn)
    n = pn(n_ndx);
    pF = {};
    for i=1:length(pxf_funcs)
        f = pxf_funcs{i};
        pF{i} = f(n);
    end
    fprintf('Running experiment for n = %d\n', n);
    for cs_ndx=1:length(cs_parms)
        cs_par = cs_parms(cs_ndx);
        fprintf('  running experiment for cs_par = %g\n', cs_par);
        cs = cs_func(cs_par);
        cs = cs(1:min(length(cs),n));
        C = make_finite_cov_matrix_from_cs(cs,n);
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
                Y = randn(n,N);
                X = C_05*Y;
                C_N = 1/N*(X*X');

                % manually compute the sample covariance approximation and
                % store it with all of the methods (unchanged by transforms)
                results(n_ndx, cs_ndx, N_ndx, :, iter, 1) = norm(C_N - C, 'fro')^2 / norm_C^2;

                for meth_id=1:length(pxf_funcs)
                    
                    % matrix transforming grid space to spectral/wavelet space
                    F = pF{meth_id};
                    C_F = F*C*F';
                    D_F = diag(diag(C_F));

                    % sample covariance in spectral/wavelet space
                    C_FN = F*C_N*F';

                    % diagonalize
%                     M = triu(ones(n)) - triu(ones(n), 2);
%                     M = M + M' - eye(n);
%                     D_FN = C_FN .* M;

                    D_FN = diag(diag(C_FN));
                    
                    % compute Frob norm of off-diagonal elements
                    results(n_ndx,cs_ndx,N_ndx,meth_id,iter,3) = norm(C_F - D_F, 'fro')^2 / norm_C^2;
                    
                    % compute Frob norm of on-diagonal elements only
                    results(n_ndx,cs_ndx,N_ndx,meth_id,iter,4) = norm(D_FN - D_F, 'fro')^2 / norm_C^2;

                    % compute errors
                    results(n_ndx, cs_ndx, N_ndx, meth_id, iter, 2) = norm(D_FN - C_F, 'fro')^2 / norm_C^2;
                end
                
                % append analytical prediction (that however assumes a
                % boundary-condition extended domain)
                
                results(n_ndx,cs_ndx,N_ndx,5,iter,1:2) = 2.0/N;
            end
        end
    end
end
