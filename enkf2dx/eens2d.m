% extend the modeled state by copying the selected varible and setting it
% to zero outside the mask
%
%
%  function Y=eens2d(X,M,var)
%    X - ensemble
%    M - mask matrix
%    var - variable index
%

function Y=eens2d(X,M,var)
    [nx,ny,nvar,N] = size(X);
    Y = zeros(nx,ny,nvar+1,N);
    Y(:,:,2:nvar+1,:) = X;
    Y(:,:,1,:) = squeeze(X(:,:,var,:)).*repmat(M,[1 1 N]);
end