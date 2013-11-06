
%% This is a plotting script for the results of exp_finite_stationary_diagonal_approximation_all


figure(1);
for N_ndx=1:length(pN)
    N = pN(N_ndx);
    subplot(2,3,N_ndx);
    semilogx(palpha, mean(squeeze(results(:,N_ndx,1,:,1)),2), 'ro-'); hold on;
    semilogx(palpha, mean(squeeze(results(:,N_ndx,2,:,1)),2), 'go-');
    semilogx(palpha, mean(squeeze(results(:,N_ndx,3,:,1)),2), 'bo-');
    semilogx(palpha, mean(squeeze(results(:,N_ndx,4,:,1)),2), 'ko-');
    semilogx(palpha, mean(squeeze(results(:,N_ndx,5,:,1)),2), 'mo-'); hold off;
    legend(pmethods);
    xlabel('alpha [-]');
    ylabel('Cov. estimate Frobenius error');
    title(sprintf('Ensemble size %d - Sample cov.', N));
end
