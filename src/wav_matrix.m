%
% Construct an (orthogonal) wavelet transform matrix.
%  
% synopsis: W = wav_matrix(n,L,wtype,arg)
%
%  n - dimensionality of space
%  L - coarsest level (see FWT_PO)
%  wtype - wavelet type (see MakeONFilter)
%  arg - argument to MakeONFilter, meaning depends on wtype
%
%

function W = wav_matrix(n,L,wtype,arg)
    qmf = MakeONFilter(wtype,arg);
    W = zeros(n);
    e = zeros(n,1);
    for i=1:n
        e(:) = 0;
        e(i) = 1.0;
        W(:,i) = FWT_PO(e,L,qmf);
    end
end