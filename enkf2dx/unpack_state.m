
% Unpacks the state of the water wave model from one column X
% into the variables H,U,V.
%
% Y = unpack_state(X,n)
%   X - packed state
%   n - dimension of 2D spatial field
%
%

function Y = unpack_state(X,n)
    [m,N] = size(X);
    m = m/n^2;
    Y = reshape(X,n,n,m,N);
end