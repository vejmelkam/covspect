

%% In this experiment, the parameter changed is the variance of each
%  data point, i.e. var(i) = 1 + g + g*sin(pi*t/n)
clear;
pn = 2.^7;                    % dimensionality of spaces (no. of grid points)
pN = 1:4:29;                  % ensemble sizes
iters = 30;                   % number of iterations with each configuration
a = 1.0;
b = 0.0;
e1 = 0.0;
%g = 4.0;
e2 = [40];
cs_parms = [1 2 4 8 16 32];               % range for modified parameter
make_cov_func = @(x,n) make_finite_cov_matrix(a,b,e1,x,e2,n,n);
show_matrix = 0;

% run the standard experiment
exp_finite_nonstationary_diagonal_approximation_all

% make the first plot (vs. cs_par)
plot_finite_stationary_diagonal_approximation_all_1(pmethods,results, pn, pN, cs_parms, 'SouthEast');
print -dpng 'fish_nonstationary_zerobc_pn128_vs_cs_alpha.png'
close all

% make the second plot (vs. ens size) WITH sample cov
plot_finite_stationary_diagonal_approximation_all_2(pmethods,results, pn, pN, cs_parms, 1);
print -dpng 'fish_nonstationary_zerobc_pn128_vs_N_with_sample_alpha.png'
close all

% make the second plot (vs. ens size) WITHOUT sample cov
plot_finite_stationary_diagonal_approximation_all_2(pmethods,results, pn, pN, cs_parms, 0);
print -dpng 'fish_nonstationary_zerobc_pn128_vs_N_without_sample_alpha.png'
close all


%% In this experiment, the parameter changed is the variance of each
%  data point, i.e. var(i) = 1 + g + g*sin(pi*t/n)
clear;
pn = 2.^7;                    % dimensionality of spaces (no. of grid points)
pN = 1:4:29;                  % ensemble sizes
iters = 30;                   % number of iterations with each configuration
a = 1.0;
%b = 0.0;
e1 = [30];
g = 0;
e2 = 0;
cs_parms = 1:4:11;           % range for modified parameter
make_cov_func = @(x,n) make_finite_cov_matrix(a,x,e1,g,e2,n,n/4);
show_matrix = 0;

% run the standard experiment
exp_finite_nonstationary_diagonal_approximation_all

% make the first plot (vs. cs_par)
plot_finite_stationary_diagonal_approximation_all_1(pmethods,results, pn, pN, cs_parms, 'NorthEast');
print -dpng 'smooth_nonstationary_zerobc_pn128_vs_cs_alpha.png'
close all

% make the second plot (vs. ens size) WITH sample cov
plot_finite_stationary_diagonal_approximation_all_2(pmethods,results, pn, pN, cs_parms, 1);
print -dpng 'smooth_nonstationary_zerobc_pn128_vs_N_with_sample_alpha.png'
close all

% make the second plot (vs. ens size) WITHOUT sample cov
plot_finite_stationary_diagonal_approximation_all_2(pmethods,results, pn, pN, cs_parms, 0);
print -dpng 'smooth_nonstationary_zerobc_pn128_vs_N_without_sample_alpha.png'
close all