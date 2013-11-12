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
% use the following methods for approximating sample covariance
pmethods = { 'DST', 'DCT', 'FFT', 'Coiflet/diag', 'Coiflet/10', 'Coiflet/b2', 'Analytical' };  % use the following xforms
pxf_funcs = { @dst_matrix, @dct_matrix, @fft_matrix, @(n) wav_matrix(n,3,'Coiflet',3), @(n) wav_matrix(n,3,'Coiflet',3), @(n) wav_matrix(n,3,'Coiflet',3) };
mask_funcs = { @(n) eye(n), @(n) eye(n), @(n) eye(n), @(n) wav_mask(n,[]), @(n) corner_mask(n,10), @(n) band_mask(n,2) };  

% run the standard experiment
exp_finite_nonstationary_diagonal_approximation_all

% make the second plot (vs. ens size) WITHOUT sample cov
plot_finite_stationary_diagonal_approximation_all_2(pmethods,results, pn, pN, cs_parms, 0);