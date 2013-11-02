
%
%  Constructs a matrix that applies the stationary covariance represented
%  by cs to an appropriately periodically extended vector (see:
%  dst_extend_bc, dct_extend_bc).
%
%  Cb = make_band_cov_oper(cs, n)
%
%  cs - vector representation of stationary covariance in the form c(0),
%       c(1), ..., c(m)
%  n - the dimensionality of the vectors (original space, not extended) for
%      which the covariance is to be constructed
%
%

function Cb = make_band_cov_oper(cs, n)
    m = length(cs) - 1;
    s = n+2*m;
    r = [cs(m+1:-1:2), cs, zeros(1, s - 2*m - 1)];
    c = [cs(m+1), zeros(1, s-1)];
    Cb = toeplitz(c, r);
    Cb = Cb(1:n, :);
end
