
% Synopsis:  F = make_dct(n)
% Returns the n x n DST transform matrix.
% Definition looked up on http://www.mathworks.com/help/pde/ug/dst.html

function F = dst_matrix(n)
    F = sqrt(2/(n+1))*sin((pi/(n+1))*([1:n]'*[1:n]));
end
