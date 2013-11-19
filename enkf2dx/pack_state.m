
% Packs the state of the water wave model into one column X.
%
% X = pack_state(H,U,V)
%

function X = pack_state(H,U,V)
    n = size(H,1);
    X = zeros(3*n*n,1);
    X(1:n*n) = H(:);
    X(n*n+1:n*n*2) = U(:);
    X(n*n*2+1:n*n*3) = V(:);
end