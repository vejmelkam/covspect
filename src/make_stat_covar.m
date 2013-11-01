
%
%  Constructs a stationary covariance matrix from the stationary
%  covariance representation cs (see banded_cov_oper) for application to
%  vectors of dimensionality n.  The form of the covariance depends on the
%  choice of the periodic boundary conditions (bc_func).
%
%  C = make_stat_covar(cs, n, bc_func)
%
%  cs - the stationary covariance representation cs in the form c(0), c(1),
%       ... c(m)
%  n - dimension of resulting covariance matrix
%  bc_func - the function used to periodically extend the vectors (must
%       match choice of basis vectors - dst,dct,fft)

function C = make_stat_covar(cs, n, bc_func)
    m = length(cs) - 1;
    Cb = cov_banded(cs, n);
    E = bc_func(eye(n),m);
    C = Cb(m+1:m+n,:) * E;
end