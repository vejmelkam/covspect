
%% This is a plotting script for the results of exp_finite_stationary_diagonal_approximation_all


figure(1);
for N_ndx=1:length(pN)
    N = pN(N_ndx);
    subplot(2,length(pN),N_ndx);
    semilogx(palpha, mean(squeeze(results(:,N_ndx,1,:,1)),2), 'ro-'); hold on;
    semilogx(palpha, mean(squeeze(results(:,N_ndx,2,:,1)),2), 'go-');
    semilogx(palpha, mean(squeeze(results(:,N_ndx,3,:,1)),2), 'bo-');
    semilogx(palpha, mean(squeeze(results(:,N_ndx,4,:,1)),2), 'ko-'); hold off;
    legend(pmethods);
    xlabel('alpha [-]');
    ylabel('Sample cov. Frobenius error');
    title(sprintf('Ensemble size %d - Sample cov.', N));

    subplot(2,length(pN),N_ndx + length(pN));
    semilogx(palpha, mean(squeeze(results(:,N_ndx,1,:,2)),2), 'ro-'); hold on;
    semilogx(palpha, mean(squeeze(results(:,N_ndx,2,:,2)),2), 'go-');
    semilogx(palpha, mean(squeeze(results(:,N_ndx,3,:,2)),2), 'bo-');
    semilogx(palpha, mean(squeeze(results(:,N_ndx,4,:,2)),2), 'ko-'); hold off;
    legend(pmethods);
    xlabel('alpha [-]');
    ylabel('Diag. sample cov. Frobenius error');
    title(sprintf('Ensemble size %d - Diag. sample cov.', N));
end
