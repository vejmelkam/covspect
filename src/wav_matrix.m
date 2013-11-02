

function W = wav_matrix(n,L,qmf)
    W = zeros(n);
    e = zeros(n,1);
    for i=1:n
        e(:) = 0;
        e(i) = 1.0;
        W(:,i) = FWT_PO(e,L,qmf);
    end
end