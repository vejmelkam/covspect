%   Function convert variable measured on a regulalar 3 dimensional grid to
%   staggered grid in selected dimension. 
%
%   Extrapolation is done using the simplest approach - in  1D case the
%   vector X=(X_1,...,X_n) is extended to Y=(Y_1,...,Y_(n+1)):
%
%   Y_1 = X_1
%   Y_(n+1) = X_n
%   Y_i = (X_(i-1) + X_i)/2 for i=2,...,n
%
%   function Y=grid2stag(X,namedim)
%       X           - 3 dimensional array
%       namedim     - character, posible values 'X', 'Y' or 'Z' , names of dimension 
%                   which is staggered
%   
function Y=grid2stag(X,namedim)
    [nx,ny,nz] = size(X);
    xi1 = 1:nx;xi2 = 1:nx;
    yi1 = 1:ny;yi2 = 1:ny;
    zi1 = 1:nz;zi2 = 1:nz;
    
    switch namedim
        case 'X'
            xi1 = [1 1:nx];
            xi2 = [1:nx nx];
        case 'Y'
            yi1 = [1 1:ny];
            yi2 = [1:ny ny];
        case 'Z'
            zi1 = [1 1:nz];
            zi2 = [1:nz nz];
        otherwise
            disp('Dimension name must be one of: X,Y,Z');
    end  
    Y = (X(xi1,yi1,zi1) + X(xi2,yi2,zi2))/2;
end