%   Assimilation run for 2d model on square grid (n x n)
%
%   
%   Y - true state
%   X - initial ensemble
%   m_f - model advance (function handle)
%   ass_f - method of assimilation (function handle)



function XA = assim2d(ens,obs,m_f,ass_f)
    %   n - grid size
    %   nvar - number of variables
    %   rl - run length (number of assimilation cycles) 
    [n,~,nvar,N] = size(ens);
    rl = size(obs,3);
    XA = zeros(n,n,nvar,rl);
    fprintf('Assimilation run, %g cycles\n',rl);
    for rl_ind = 1:rl
        fprintf('.')
        ens = ass_f(ens,squeeze(obs(:,:,rl_ind)));
        XA(:,:,:,rl_ind)=unpack_state(mean(pack_state(ens),2),n);
        for ens_ind = 1:N
            ens(:,:,:,ens_ind) = m_f(squeeze(ens(:,:,:,ens_ind)));
        end 
        if mod(rl_ind,10)==0
            fprintf('\n');
        end
    end 
end
