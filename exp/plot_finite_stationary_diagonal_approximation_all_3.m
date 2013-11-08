
%% This is a plotting script for the results of exp_finite_stationary_diagonal_approximation_all

for cs_ndx=1:length(cs_parms)
    cs_par = cs_parms(cs_ndx);
    figure('name', sprintf('Plots vs. dimension, cs_par=%g', cs_par));
    for N_ndx=1:length(pN)
        N = pN(N_ndx);
        subplot(2,4,N_ndx);
        plot(pn, mean(squeeze(results(:,cs_ndx,N_ndx,1,:,1)),2), 'ro-'); hold on;
        plot(pn, mean(squeeze(results(:,cs_ndx,N_ndx,1,:,2)),2), 'ro-');
        plot(pn, mean(squeeze(results(:,cs_ndx,N_ndx,2,:,2)),2), 'go-');
        plot(pn, mean(squeeze(results(:,cs_ndx,N_ndx,3,:,2)),2), 'bo-');
        plot(pn, mean(squeeze(results(:,cs_ndx,N_ndx,4,:,2)),2), 'ko-');
        plot(pn, mean(squeeze(results(:,cs_ndx,N_ndx,5,:,2)),2), 'mo-'); hold off;
        legend([{'Sample'} pmethods(1:5)]);
        xlabel('dimension of system [-]');
        ylabel('Cov. estimate Frobenius error');
        title(sprintf('Ensemble size %d - Sample cov.', N));
    end
end
