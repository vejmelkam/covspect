%       Transforming ensembles consisting of 3 dimensional arrays of multiple variables
%       regular mesh to spectral space and packing it to matrix, where each
%       ensemble member is stored in one column.
%
%
%       function X = transf_pack_3d(X,f_trans_m)
%           X - 5 dimensinal array (1-3 - grid dimensions, 4 - variable
%           index, 5 - ensemble member index)
%           f_trans_m - function handle, function for creating
%           transformation matrix
%
%           result X - matrix with N columns, where each column is one
%           packed ensemble member

function X = transf_pack_3d(X,f_trans_m)
    [nx,ny,nz,nvar,N] = size(X);
    
    %   X dimension transformation matrix
    Tx = f_trans_m(nx);
    
    %   Y dimension transformation matrix, will be applied on rows, so must
    %   be transposed (non-conjugate transposition!!!)
    Ty = f_trans_m(ny).';
    
    %   Z dimension transformation matrix, will be applied on rows
    Tz = f_trans_m(nz).';
    
    for N_ind = 1:N
        for var_ind = 1:nvar
            
            %   apply Tx on colums and Ty on rows
            for z_ind = 1:nz
                X(:,:,z_ind,var_ind,N_ind) = Tx*squeeze(X(:,:,z_ind,var_ind,N_ind))*Ty;
            end
            %   apply Tz
            for y_ind = 1:ny
                X(:,y_ind,:,var_ind,N_ind) = squeeze(X(:,y_ind,:,var_ind,N_ind))*Tz;
            end
        end
    end
    
    % pack state
    X = reshape(X,nx*ny*nz*nvar,N);
end
