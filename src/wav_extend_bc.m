
% Extend a given vector to satisfy periodic conditions for the discrete
% cosine transformed returned by make_dct().
%
% u2 = wav_extend_bc(u,m)
%
% u - the vector (or matrix) that is to be extended (vertically)
% m - the maximum range for which the covariance is nonzero
%

function u2 = wav_extend_bc(u,m)
    n = size(u,1);
    assert(m < n, 'The extent of the covariance function m must be strictly smaller than the dimensionality of the vector u.');
%    u2 = [ u(m+1:-1:2,:); u; u(n-1:-1:n-m,:) ];
    u2 = [ u(n-m+1:n,:); u; u(1:m,:) ];
end