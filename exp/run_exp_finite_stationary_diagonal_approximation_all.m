clear;
pn = 128;                            % dimensionality of spaces (no. of grid points)
pN = 1:4:31;                         % ensemble sizes
iters = 50;                          % number of iterations with each configuration
cs_parms = [0.1 1 10];               % parameters fo cs
cs_func = @make_cs_exp_alpha;        % function, which create covariance operator vector
mask_funcs = { @(n) eye(n), @(n) eye(n), @(n) eye(n), @(n) wav_mask(n,[2,3]) };  


% run the standard experiment
exp_finite_stationary_diagonal_approximation_all

% make the second plot (vs. ens size) WITH sample cov
plot_finite_stationary_diagonal_approximation_all_2(pmethods,results, pn, pN, cs_parms, 1);

% make the second plot (vs. ens size) WITHOUT sample cov
plot_finite_stationary_diagonal_approximation_all_2(pmethods,results, pn, pN, cs_parms, 0);
