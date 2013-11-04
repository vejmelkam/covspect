

function F = fft_matrix(n)

    F = zeros(n);
    e = zeros(n,1);
    n_05 = 1.0 / sqrt(n);
    for i = 1:n
        e(:) = 0.0;
        e(i) = 1;
        F(:,i) = n_05 * fft(e);
    end
end
