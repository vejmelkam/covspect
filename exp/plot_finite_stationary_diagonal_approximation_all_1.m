
%% This is a plotting script for the results of exp_finite_stationary_diagonal_approximation_all

figure(1);
for n_ndx=1:length(pn)
    n = pn(n_ndx);
    for N_ndx=1:length(pN)
        N = pN(N_ndx);
        subplot(2,3,N_ndx);
        plot(cs_parms, mean(squeeze(results(:,N_ndx,1,:,1)),2), 'ro-'); hold on;
        plot(cs_parms, mean(squeeze(results(:,N_ndx,2,:,2)),2), 'go-');
        plot(cs_parms, mean(squeeze(results(:,N_ndx,3,:,2)),2), 'bo-');
        plot(cs_parms, mean(squeeze(results(:,N_ndx,4,:,2)),2), 'ko-');
        plot(cs_parms, mean(squeeze(results(:,N_ndx,5,:,2)),2), 'mo-'); hold off;
        legend(pmethods(1:5));
        xlabel('cs_parameter [-]');
        ylabel('Cov. estimate Frobenius error');
        title(sprintf('Ensemble size %d - Sample cov.', N));
    end
end
