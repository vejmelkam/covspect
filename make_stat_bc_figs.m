

clear;
pn = 128;                            % dimensionality of spaces (no. of grid points)
pN = 1:4:31;                         % ensemble sizes
iters = 50;                          % number of iterations with each configuration
cs_parms = [0.1 1 10];               % parameters fo cs
cs_func = @make_cs_exp_alpha;        % function, which create covariance operator vector
mask_funcs = { @(n) eye(n), @(n) eye(n), @(n) eye(n), @(n) eye(n) };  


% run the standard experiment
exp_stationary_sample_and_diagonal_approximation

% make the first plot (vs. cs_par)
plot_finite_stationary_diagonal_approximation_all_1(pmethods,results, pn, pN, cs_parms, 'SouthEast');
print -dpng 'stationary_bc_pn128_vs_cs_alpha.png'
close all

% make the second plot (vs. ens size) WITH sample cov
plot_finite_stationary_diagonal_approximation_all_2(pmethods,results, pn, pN, cs_parms, 1);
print -dpng 'stationary_bc_pn128_vs_N_with_sample_alpha.png'
close all

% make the second plot (vs. ens size) WITHOUT sample cov
plot_finite_stationary_diagonal_approximation_all_2(pmethods,results, pn, pN, cs_parms, 0);
print -dpng 'stationary_bc_pn128_vs_N_without_sample_alpha.png'
close all


clear;
pn = 128;                            % dimensionality of spaces (no. of grid points)
pN = 1:4:31;                         % ensemble sizes
iters = 50;                          % number of iterations with each configuration
cs_parms = [0.5 1 2 4];              % parameters fo cs
cs_func = @make_cs_exp_beta;         % function, which create covariance operator vector
mask_funcs = { @(n) eye(n), @(n) eye(n), @(n) eye(n), @(n) eye(n) };  

% run the standard experiment
exp_stationary_sample_and_diagonal_approximation

% make the first plot (vs. cs_par)
plot_finite_stationary_diagonal_approximation_all_1(pmethods,results, pn, pN, cs_parms, 'SouthEast');
print -dpng 'stationary_bc_pn128_vs_cs_beta.png'
close all

% make the second plot (vs. ens size) WITH sample cov
plot_finite_stationary_diagonal_approximation_all_2(pmethods,results, pn, pN, cs_parms, 1);
print -dpng 'stationary_bc_pn128_vs_N_with_sample_beta.png'
close all

% make the second plot (vs. ens size) WITHOUT sample cov
plot_finite_stationary_diagonal_approximation_all_2(pmethods,results, pn, pN, cs_parms, 0);
print -dpng 'stationary_bc_pn128_vs_N_without_sample_beta.png'
close all


clear;
pn = 128;                            % dimensionality of spaces (no. of grid points)
pN = 1:4:31;                         % ensemble sizes
iters = 50;                          % number of iterations with each configuration
cs_parms = [1 2 4 8 16 32 64];                   % parameters fo cs
cs_func = @make_cs_triangle;         % function, which create covariance operator vector
mask_funcs = { @(n) eye(n), @(n) eye(n), @(n) eye(n), @(n) eye(n) };  


% run the standard experiment
exp_stationary_sample_and_diagonal_approximation

% make the first plot (vs. cs_par)
plot_finite_stationary_diagonal_approximation_all_1(pmethods,results, pn, pN, cs_parms, 'SouthEast');
print -dpng 'stationary_bc_pn128_vs_cs_tri.png'
close all

% make the second plot (vs. ens size) WITH sample cov
plot_finite_stationary_diagonal_approximation_all_2(pmethods,results, pn, pN, cs_parms, 1);
print -dpng 'stationary_bc_pn128_vs_N_with_sample_tri.png'
close all

% make the second plot (vs. ens size) WITHOUT sample cov
plot_finite_stationary_diagonal_approximation_all_2(pmethods,results, pn, pN, cs_parms, 0);
print -dpng 'stationary_bc_pn128_vs_N_without_sample_tri.png'
close all
