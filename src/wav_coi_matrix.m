
% Synopsis:  F = wav_coi_matrix(n)
% Returns the n x n wavelet transform matrix, using Coiflets.
% Need Wavelab850.


function W = wav_coi_matrix(n)
    qmf = MakeONFilter('Coiflet',2);
    W=zeros(n);
    L = 4;
    for i=1:n
        e=zeros(n,1); 
        e(i)=1; 
        W(:,i)=FWT_PO(e,L,qmf); 
    end; 
end