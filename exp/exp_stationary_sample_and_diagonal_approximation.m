
%% Explanation
%
%   This experiment compares sample covariance and diagonal sample
%   covariance estimates for stationary random field defined on infinite
%   dimensional periodic vector space. Estimates are compared in various 
%   spectral spaces (DST, DCT, FFT) using regarding boudary conditions. 
%   


%% Parameters

clear;
pn = 100;                     % dimensionality of spaces (no. of grid points)
pN = 1:10;                     % ensemble sizes
iters = 25;                   % number of iterations with each configuration
cs_parms = [0.5 1 2 5];                % parameters fo cs
cs_func = @make_cs_exp; % function, which create covariance operator vector

pmethods = {'DST','DCT','FFT' };  % use the following xforms
tm_funcs = {@dst_matrix, @dct_matrix, @fft_matrix};
bc_funcs = {@dst_extend_bc, @dct_extend_bc, @fft_extend_bc};

%   errors in each simulation
%   last dimension stands for error using:
%   1 - whole sample covariance 
%   2 - diagonal elements of sample covariance
results=zeros(length(cs_parms),length(pN),length(pmethods),iters,2);


for cs_ind = 1:length(cs_parms)
    cs_parm=cs_parms(cs_ind);
    fprintf('Running experiment for cs parameter = %g\n', cs_parm);
    cs = cs_func(cs_parm);
    % spectral covariances
    Cs={}; 
    normCs=zeros(length(pmethods));
    for t_ind = 1:length(pmethods)
        % true spectral covariances
        Cs{t_ind}=make_spectral_cov(cs,pn,tm_funcs{t_ind},bc_funcs{t_ind});
        normCs(t_ind)=norm(Cs{t_ind},'fro');
    end 
    for N_ind = 1:length(pN)
        N=pN(N_ind);
        for iter_ind = 1:iters
            % Y ~ N(0,I), ens. members in columns
            Y = randn(pn,N); 
            for t_ind = 1:length(pmethods)
                Ctrue = Cs{t_ind};
                X = sqrtm(Ctrue)*Y;
                Csample = 1/N*(X*X');
                DiagC = diag(diag(Csample));
                %erros
                results(cs_ind,N_ind,t_ind,iter_ind,1)=norm(Ctrue-Csample,'fro')/normCs(t_ind);
                results(cs_ind,N_ind,t_ind,iter_ind,2)=norm(Ctrue-DiagC,'fro')/normCs(t_ind);
            end
        end
    end
end
