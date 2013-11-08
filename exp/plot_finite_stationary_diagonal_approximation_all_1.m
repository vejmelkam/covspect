
%% This is a plotting script for the results of exp_finite_stationary_diagonal_approximation_all

function plot_finite_stationary_diagonal_approximation_all_1(pmethods, results, pn, pN, cs_parms, legend_pos)

nmeth = length(pmethods);

for n_ndx=1:length(pn)
    n = pn(n_ndx);
    figure('name', sprintf('vs_cs pn=%d', n),'units','normalized','outerposition',[0 0 1 1]);
    for N_ndx=1:length(pN)
        N = pN(N_ndx);
        subplot(2,4,N_ndx);
        semilogx(cs_parms, mean(squeeze(results(n_ndx,:,N_ndx,1,:,2)),2), 'ro-'); hold on;
        semilogx(cs_parms, mean(squeeze(results(n_ndx,:,N_ndx,2,:,2)),2), 'go-');
        semilogx(cs_parms, mean(squeeze(results(n_ndx,:,N_ndx,3,:,2)),2), 'bo-');
        semilogx(cs_parms, mean(squeeze(results(n_ndx,:,N_ndx,4,:,2)),2), 'ko-');
        if(nmeth > 4)
            plot(cs_parms, mean(squeeze(results(n_ndx,:,N_ndx,5,:,2)),2), 'mo-');
        end
        if(nmeth > 5)
            plot(cs_parms, mean(squeeze(results(n_ndx,:,N_ndx,6,:,2)),2), 'co-');
        end
        ylims = ylim;
        ylim([0,ylims(2)*1.2]);
        legend(pmethods, 'location', legend_pos);
        xlabel('cs\_parameter [-]');
        ylabel('Relative Frob. error square');
        title(sprintf('Ens. size %d', N));
    end
end

end