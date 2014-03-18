%%  
%   return diagonal elements in blocks of sample covariance,
%
%   function E = block_cov_vec(X,m,i)
%       X - packed ensemble, eensemble members in column
%       m - number of variables in one ensemble
%       i - index of variable, for which the covariance and cross
%       covariances will be counted
%
%%


function E = block_cov_vec(X,m,i)
    [n2m,N] = size(X);
    n2 = n2m/m;
    XM = mean(X,2);
    XD = X - repmat(XM,1,N);
    E = zeros(n2m,1);
    
    % i-th variable row from
    ri_f = (i-1)*n2+1; 
    % i-th variable row to
    ri_t = i*n2;
    
    for m_ind = 1:m
        % m_ind-th variable row from
        rm_f = (m_ind-1)*n2+1; 
        % M_ind-th variable row to
        rm_t = m_ind*n2;
        for ens_ind = 1:N
            E(rm_f:rm_t) = E(rm_f:rm_t) + XD(rm_f:rm_t,ens_ind).*conj(XD(ri_f:ri_t,ens_ind));           
        end
    end
    E = E/(N-1);
 end