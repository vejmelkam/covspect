%   3D Ensemble Kalman filter with spectral diagonal approximation of
%   forecast approximation and one variable observed. 
%
%   This implementation requires, that the whole state of one variable is
%   observed and that obeservation are indipendent with constant variation.
%   
%   The implementation is fully (mathematically) described on internal wiki 
%   https://mathweb.ucdenver.edu/~wikiuser/grantwiki/doku.php?id=spectral_enkf_for_multidimensional_data#the_enkf_update
%   (access restricted)
%
%   function XA = enkf3dx(XF,D,iv,vl,f_trans_m)
%       
%       XF - forecat ensemble, 5 dimensional array, dim 1-3 are x, y, z
%       coorinates, 4th dim is variable index, 5th dimension is ensemble
%       index
%       r - variance of the observations 
%       iv - index of variable, which will be assimilated
%       D - measurements ("true state") to be assimilated
%       f_trans_m - function handle, function to create transformation
%       matrix
%
%       XA - analysis ensemble, array with size same as XF


function XA = enkf3dx(XF,D,r,iv,f_trans_m)
    [nx,ny,nz,nv,N] = size(XF);
    [nxD,nyD,nzD] = size(D);
     
    %   dimension control
    assert(nx==nxD & ny==nyD & nz==nzD,'Dimension between ensemble and measurements does not agree.');
    
    % transformation to spectral space and packing
    XF = transf_pack_3d(XF,f_trans_m);
    
    E = mvbdca(XF,nv,iv);
    % ith variable row from and row to
    ivrf = (iv-1)*(nx*ny*nz)+1;
    ivrt = iv*nx*ny*nz;
    
    % transformation of observation and creating inovations
    D = repmat(D,[1 1 1 1 N]); %+ sqrt(r)*randn(nx,ny,nz,1,N);
    D = transf_pack_3d(D,f_trans_m);
    D = D + sqrt(r)*randn(size(D));
    %   EnKF
    D = XF(ivrf:ivrt,:) - D;
    D = repmat((E(ivrf:ivrt) + r).^(-1),[1 N]) .* D;
    XA = XF - repmat(E,[1 N]) .* repmat(D,[nv 1]);
    
    XA = itransf_unpack_3d(XA,nx,ny,nz,nv, @(x) f_trans_m(x)');    
    end