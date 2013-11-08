
%% This is a plotting script for the results of exp_finite_stationary_diagonal_approximation_all

function plot_finite_stationary_diagonal_approximation_all_2(pmethods, results, pn, pN, cs_parms, plot_sample)
    
    nmeth = length(pmethods);
    if length(cs_parms) < 5
        pltv = 1;
        plth = length(cs_parms);
    else
        pltv = 2;
        plth = 4;
    end

    for n_ndx=1:length(pn)
        n = pn(n_ndx);
        figure('name', sprintf('vs_N pn=%d', n),'units','normalized','outerposition',[0 0 1 1]);
        for cs_ndx=1:length(cs_parms)
            cs_par = cs_parms(cs_ndx);
            subplot(pltv,plth,cs_ndx);
            if(plot_sample)
                plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,1,:,1)),2), 'ro-'); hold on;
                plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,1,:,2)),2), 'go-');
                leg = {'Sample'};
            else
                plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,1,:,2)),2), 'go-'); hold on;
                leg = {};
            end
                
            plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,2,:,2)),2), 'bo-');
            plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,3,:,2)),2), 'ko-');
            plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,4,:,2)),2), 'mo-');
            if(nmeth > 4)
                plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,5,:,2)),2), 'co-');
            end
            if(nmeth > 5)
                plot(pN, mean(squeeze(results(n_ndx,cs_ndx,:,6,:,2)),2), 'yo-');
            end
            legend([leg pmethods]);
            xlabel('Ensemble size [-]');
            ylabel('Relative Frob. error sq');
            title(sprintf('Alpha %g', cs_par));
        end
    end