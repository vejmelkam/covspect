%       Inverse transformation of consisting of 3 dimensional arrays of multiple variables
%       on a regular mesh to spectral space and packing it to matrix, where each
%       ensemble member is stored in one column.
%
%
%       function X = itransf_unpack_3d(X,nx,ny,nz,nvar,f_itrans_m)
%           X - packed ensemble, where each column is one ensemble member
%           nx - x grid dimension
%           ny - y grid dimension
%           nz - z grid dimension
%           nvar - number of variables, stored in one member
%           f_trans_m - function handle, function for creating 
%           transformation matrix
%
%           result X - matrix with N columns, where each column is one
%           packed ensemble member

function X = itransf_unpack_3d(X,nx,ny,nz,nvar,f_trans_m)
    [n,N] = size(X);
    
    assert(n==nx*ny*nz*nvar,'Dimension does not agree.');
    
    %   unpack state
    X = reshape(X,[nx ny nz nvar N]);
    
    %   X dimension transformation matrix
    Tx = f_trans_m(nx);
    
    %   Y dimension transformation matrix, will be applied on rows, so must
    %   be transposed (non-conjugate transposition!!!)
    Ty = f_trans_m(ny).';
    
    %   Z dimension transformation matrix, will be applied on rows, so must
    %   be transposed 
    Tz = f_trans_m(nz).';
    
    for N_ind = 1:N
        for var_ind = 1:nvar
            
            %   apply Tx on colums and Ty on rows
            for z_ind = 1:nz
                X(:,:,z_ind,var_ind,N_ind) = Tx*squeeze(X(:,:,z_ind,var_ind,N_ind))*Ty;
            end
            %   apply Tz on rows
            for y_ind = 1:ny
                X(:,y_ind,:,var_ind,N_ind) = squeeze(X(:,y_ind,:,var_ind,N_ind))*Tz;
            end
        end
    end
end
