
% Extend a given vector to satisfy periodic conditions for the discrete
% sine transformed returned by fft_matrix.
%
% u2 = fft_extend_bc(u,m)
%
% u - the vector (or matrix) that is to be extended (vertically)
% m - the maximum range for which the covariance is nonzero
%

function u2 = fft_extend_bc(u,m)
    n = size(u,1);
    assert(m < n, 'The extent of the covariance function m must be strictly smaller than the dimensionality of the vector u.');
    u2 = [ u(n-m+1:n,:); u; u(1:m,:) ];
end
