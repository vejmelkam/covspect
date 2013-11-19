
% Unpacks the state of the water wave model from one column X
% into the variables H,U,V.
%
% [H,U,V] = unpack_state(X)
%

function [H,U,V] = unpack_state(X)
    3n2 = size(X,1);
    n = sqrt(3n2/3);
    H = zeros(n);
    H(:) = X(1:n*n);
    U = zeros(n);
    U(:) = X(n*n+1:n*n*2);
    V = zeros(n);
    V(:) = X(n*n*2+1:n*n*3);
end