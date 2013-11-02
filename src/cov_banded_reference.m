
%
% A reference implementation of the construction of a banded matrix
% from a representation cs of the stationary covariance function.
%
% synopsis: Cb = make_band_cov_oper(cs, n)
%
%  cs - the stationary covariance representation as c(0),c(1),..,c(m)
%  n  - the dimensionality of the (grid-space) vectors
%

function Cb = cov_banded_reference(cs, n)
    m = length(cs) - 1;
    s = n+2*m;
    r = [cs, zeros(1, s - m - 1)];
    Cb = toeplitz(r, r);
    Cb = Cb(m+1:m+n,:);
end
