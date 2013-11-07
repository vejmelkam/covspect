
%
%  Constructs a non-stationary covariance matrix from the non-stationary
%  covariance representation (a,b,g,t,n,m, see:make_nonstat_cov_oper) for
%  application to vectors of dimensionality n.  The form of the covariance
%  depends on the choice of the periodic boundary conditions (bc_func).
%
%  note: this is just a convenience function
%
%  C = make_nonstat_cov_matrix(cs, n, bc_func)
%
%  a (alpha) - smoothness of covariance function
%  b (beta)  - variability of smoothness of covariance function with space
%  g (gamma) - controls the magnitude of grid point variance variability
%  t (theta) - frequency of grid point variance variability
%  n         - dimension of finite part of field (also dim of covar matrix)
%  m         - controls the support of the covariance function
%  bc_func - the function used to periodically extend the vectors (must
%       match choice of basis vectors - dst,dct,fft)

function C = make_nonstat_cov_matrix(a,b,g,t,n,m,bc_func)
    Cb = make_nonstat_cov_oper(a,b,g,t,n,m);
    E = bc_func(eye(n),m);
    C = Cb * E;
end