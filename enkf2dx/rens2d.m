% reduce the model ensemble after assimilation
%
%
%  function Y=rens2d(X)
%    X - ensemble
%

function X=rens2d(X)
   nvar = size(X,3);
   X = X(:,:,2:nvar,:);
end