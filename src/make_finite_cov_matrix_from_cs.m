
%
%  Constructs a stationary covariance matrix from the stationary
%  covariance representation cs (see make_band_cov_oper) for application to
%  vectors of dimensionality n.  DISREGARDS the boundary conditions imposed
%  by any spectral/wavelet transform to be applied later.  The equivalent
%  function which takes boundary conditions into account is
%  make_stat_cov_matrix.
%
%  C = make_finite_cov_matrix(cs, n)
%
%  cs - the stationary covariance representation cs in the form c(0), c(1),
%       ... c(m)
%  n - dimension of resulting covariance matrix
%

function C = make_finite_cov_matrix_from_cs(cs, n)
    rc = [cs, zeros(1,n-length(cs))];
    C = toeplitz(rc,rc);
end