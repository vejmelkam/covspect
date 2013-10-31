

function F = make_dct(n)


    F = zeros(n);
    e = zeros(n,1);
    for i = 1:n
        e(:) = 0.0;
        e(i) = 1;
        F(:,i) = dct(e);
    end
end
