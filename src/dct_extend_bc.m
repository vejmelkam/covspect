
% Extend a given vector to satisfy periodic conditions for the discrete
% cosine transformed returned by make_dct().
%
% u2 = dct_extend_bc(u,m)
%
% u - the vector (or matrix) that is to be extended (vertically)
% m - the maximum range for which the covariance is nonzero
%

function u2 = dct_extend_bc(u,m)
    [n, N] = size(u);
    assert(m < n, 'The extent of the covariance function m must be strictly smaller than the dimensionality of the vector u.');
    u2 = [ u(m:-1:1,:); u; u(n:-1:n-m+1,:) ];
end