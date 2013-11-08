
%% This is a plotting script for the results of exp_finite_stationary_diagonal_approximation_all

for n_ndx=1:length(pn)
    n = pn(n_ndx);
    figure('name', sprintf('pn=%d', n));
    for cs_ndx=1:length(cs_parms)
        cs_par = cs_parms(cs_ndx);
        subplot(2,3,cs_ndx);
        plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,1,:,1)),2), 'ro-'); hold on;
        plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,1,:,2)),2), 'go-');
        plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,2,:,2)),2), 'bo-');
        plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,3,:,2)),2), 'ko-');
        plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,4,:,2)),2), 'mo-');
        plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,5,:,2)),2), 'co-');
        legend([{'Sample'} pmethods(1:6)]);
        xlabel('Ensemble size [-]');
        ylabel('Cov. estimate Frobenius error');
        title(sprintf('Alpha parameters %g - Sample cov. ', cs_par));
    end
end