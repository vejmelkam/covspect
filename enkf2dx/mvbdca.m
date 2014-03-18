%   mvbdca - Multli Variable Block Diagonal (cross) Covariance Approximation
%
%   Diagonal aproximation of covariance and cross-covariances of the ensemble 
%   matrix X, ensemble members are columns of the matrix.
%   
%   Ensemble members consist of multipled variables measured (simulated) on
%   a multidimensional grid. All variables must be measured on the same
%   grid. The covariance is approzimated by taking the diagonal elements
%   from sample covariance matrix.
%   
%   Function computes diagonal elements of sample covariance matrix for one variable
%   Y_i and and diagonal elements of sample crosscovariances between Y_i and 
%   other variables (Y_j, j!=i).
%
%   usage:
%
%   E = mvbdca(X,nv,i)
%
%       input:
%           X   matrix containg ensemble members in columns 
%                   - X = (X_1,...,X_N)
%                   - each ensemble member contains m variables
%                     X_k = (Y_k1^T,...,Y_km^T)^T
%                       - Y_kj vectorized variable measured on multidimensional
%                       regular mesh
%           (same) regular mesh
%           nv  length of one variable vector (number of rows of X must be
%               integer multiple of m)
%           i   index, for which variable will the aproximation be computed
%       
%       output:
%           E   vector of length nv*m 
%                   - E^T = (E_1^T,...,E_m^T) 
%                   - (E_j)_k is (sample) covariance between (Y_.j)_k and
%                   (Y_.i)_k

function E = mvbdca(X,nv,i)
    [n,N] = size(X);
    assert(mod(n,nv)==0,'size(X,1) must be multiplication of nv');
    m = n/nv; 
    
    %   mean 
    XM = mean(X,2);
    %   deviations
    X = X - repmat(XM,[1 N]);
    
    % i-th variable, row from, row to
    iv_rf = (i-1) * m + 1;
    iv_rt = i*m;
    
    
    C = X .* repmat(conj(X(iv_rf:iv_rt,:)),nv,1);
    
    E = 1/(N-1) * sum(C,2);
end