%   Function convert variable measured on a stagered grid to regulalar 3
%   dimensional grid.
%
%   Interpolation is done using the simplest approach - in  1D case the
%   vector X=(X_1,...,X_n) is  transformed  to Y=(Y_1,...,Y_(n-1)):
%
%   
%  
%   Y_i = (X_(i) + X_(i+1))/2 for i=1,...,n-1
%
%   function Y=grid2stag(X,namedim)
%       X - 3 dimensional array
%       namedim - names of dimension which is staggered, character - 'X' or
%       'Y' or 'Z'
%   
function Y=stag2grid(X,namedim)
    [nx,ny,nz] = size(X);
    xi1 = 1:nx;xi2 = 1:nx;
    yi1 = 1:ny;yi2 = 1:ny;
    zi1 = 1:nz;zi2 = 1:nz;
    
    switch namedim
        case 'X'
            xi1 = 1:nx-1;
            xi2 = 2:nx;
        case 'Y'
            yi1 = 1:ny-1;
            yi2 = 2:ny;
        case 'Z'
            zi1 = 1:nz-1;
            zi2 = 2:nz;
        otherwise
            disp('Dimension name must be one of: X,Y,Z');
    end  
    Y = (X(xi1,yi1,zi1) + X(xi2,yi2,zi2))/2;
end