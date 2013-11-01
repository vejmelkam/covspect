
% Extend a given vector to satisfy periodic conditions for the discrete
% sine transformed returned by make_dst().
%
% u2 = dst_extend_bc(u,m)
%
% u - the vector (or matrix) that is to be extended (vertically)
% m - the maximum range for which the covariance is nonzero
%

function u2 = dst_extend_bc(u,m)
    [n, N] = size(u);
    assert(m < n, 'The extent of the covariance function m must be strictly smaller than the dimensionality of the vector u.');
    u2 = [ -u(m-1:-1:1,:); zeros(1,N); u; zeros(1,N); -u(n:-1:n-m+2,:) ];
end
