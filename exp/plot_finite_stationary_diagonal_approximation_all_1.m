
%% This is a plotting script for the results of exp_finite_stationary_diagonal_approximation_all


figure(1);
for N_ndx=1:length(pN)
    N = pN(N_ndx);
    subplot(2,3,N_ndx);
    semilogx(cs_parms, mean(squeeze(results(:,N_ndx,1,:,1)),2), 'ro-'); hold on;
    semilogx(cs_parms, mean(squeeze(results(:,N_ndx,2,:,2)),2), 'go-');
    semilogx(cs_parms, mean(squeeze(results(:,N_ndx,3,:,2)),2), 'bo-');
    semilogx(cs_parms, mean(squeeze(results(:,N_ndx,4,:,2)),2), 'ko-'); hold off;
    legend(pmethods(1:4));
    xlabel('cs_parameter [-]');
    ylabel('Cov. estimate Frobenius error');
    title(sprintf('Ensemble size %d - Sample cov.', N));
end
