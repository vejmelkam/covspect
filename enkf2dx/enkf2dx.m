
%%
%   EnKF with observation of entire state. 
%
%   Implemenation based on J. Mandel: A  Brief Tutorial on 
%   the Ensemble Kalman Filter 
%   http://arxiv.org/abs/0901.3725
%
%
%   function XA=enkf2dx(XF,H,d,r,f_cov_est)
%
%   XF - forecast ensemble
%   d - observed data (matrix)
%   r - variance of observed data - covariance matrix of observed data is
%   then r*I
%   i - index of observed variable
%   Qx - transformation matrix for rows
%   Qy - transformation matrix for columns
%  
%%
function XA=enkf2dx(XF,d,r,i,Qx,Qy)
    % nx,ny - grid dimension
    % N - number of ensemble members
    [nx,ny,m,N] = size(XF);
    

    X = zeros(size(XF));
    % transform ensemble to spectral space
    for ens_ind = 1:N
        for m_ind = 1:m
            X(:,:,m_ind,ens_ind)=Qx*squeeze(XF(:,:,m_ind,ens_ind))*Qy';
        end
    end
    X = pack_state(X);
    
    % transform, pack and perturbate data to spectral space
    D = repmat(pack_state(Qx*d*Qy'),1,N)+randn(nx*ny,N)*sqrt(r);
    
    % i-th variable row from
    ri_f = (i-1)*nx*ny+1; 
    % i-th variable row to
    ri_t = i*nx*ny;
    
    % diagonal approximation of covariance matrix
    E = block_cov_vec(X,m,i);
    E_i = E(ri_f:ri_t);
    
    
    % inovation
    INOV = X(ri_f:ri_t,:) - D;
    INOV = INOV .* repmat((E_i + r).^(-1),1,N);
    INOV = repmat(INOV,m,1) .* repmat(E,1,N);
    X = X - INOV;
    
    % unpack and transform back to spatial space
    XA = unpack_state(X,nx,ny);
    for ens_ind = 1:N
        for m_ind = 1:m
            XA(:,:,m_ind,ens_ind)=Qx'*squeeze(XA(:,:,m_ind,ens_ind))*Qy;
        end
    end
    XA = real(XA);
end