
% Extend a given vector to satisfy periodic conditions for the waivlet 
% transformation. 
%
% u2 = wav_coi_extend_bc(u,m)
%
% u - the vector (or matrix) that is to be extended (vertically)
% m - the maximum range for which the covariance is nonzero
%

function u2 = wav_coi_extend_bc(u,m)
    [n, N] = size(u);
    assert(m < n, 'The extent of the covariance function m must be strictly smaller than the dimensionality of the vector u.');
    u2 = [ u(n-m+1:n,:); u; u(1:m,:) ];
end