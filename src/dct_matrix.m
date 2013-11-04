
% Synopsis:  F = make_dct(n)
% Returns the n x n DCT transform matrix.
% Taken from: octave matcompat, author: Paul Kienzle, GPL license
% Tested against: dct in sig. proc. toolbox and dctmtx in image proc
% toolbox

function F = dct_matrix(n)

    if(n > 1)
        F = [ sqrt(1/n)*ones(1,n) ; sqrt(2/n)*cos((pi/2/n)*([1:n-1]'*[1:2:2*n])) ];
    elseif(n == 1)
        F = 1;
    else
        error('Invalid matrix size, must be 1 ...');
    end
end
