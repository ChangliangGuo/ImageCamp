% Alt figure 2: tracking splitters across days & relationship to
% performance

%% A - plot splitters across days
plotSigSplitters_bw_sesh(G45_alt(4), G45_alt(11));
plotSigSplitters_bw_sesh(G45_alt(4), G45_alt(20));
plotSigSplitters_bw_sesh(G45_alt(20),G45_alt(21));
plotSigSplitters_bw_sesh(G30_alt(13),G30_alt(14));

%% B - PF and splitter correlations versus time

% comp_type = {'all', 'free_only', 'forced_only', 'free_v_forced'};
comp_type = {'loop_v_free', 'free_v_not', 'forced_v_free'};

for j = 1:4
    sessions = alt_all_cell{j};
    for k = 1:length(comp_type)
        splitcorr_v_time(sessions, comp_type{k})
        make_figure_pretty(gcf);
        printNK([sessions(1).Animal ' - split curve corrs v time comp_type - ' ...
            comp_type{k}],'alt')
        close(gcf)
    end
end



%% Prob maintains phenotype versus days...
max_day_lag = 7;
sessions = alt_all_cell; % Change this to make plots for each mouse...

nmice = length(sessions);
stay_prop_v_days = cell(1, max_day_lag + 1);
coactive_prop_v_days = cell(1, max_day_lag + 1);

% Get probabilities for each mouse and day lag
hw = waitbar(0,'Get proportions across days');
for j = 0:max_day_lag
    [ stay_prop, coactive_prop, cat_names ] = ...
        alt_stab_v_cat_batch(j, 'exact', sessions, 'Placefields_cm1.mat');
    stay_prop_v_days{j+1} = stay_prop;
    coactive_prop_v_days{j+1} = coactive_prop;
    waitbar((j+1)/max_day_lag,hw);
end
close(hw)

%%
grps_all = []; stay_prop_all = []; coactive_prop_all = [];
for j = 0:max_day_lag
    prop_for_day = cat(1, stay_prop_v_days{j+1}{:});
    stay_prop_all = cat(1, stay_prop_all, prop_for_day);
    coactive_for_day = cat(1, coactive_prop_v_days{j+1}{:});
    coactive_prop_all = cat(1, coactive_prop_all, coactive_for_day);
    grps_by_day = ones(size(prop_for_day))*j;
    size(grps_by_day)
    grps_all = cat(1, grps_all, grps_by_day);
    
end

% Plot and get stats for splitters
figure
set(gcf,'Position', [2000, 30, 1650, 890])
hstay = subplot(2, 3, 1:2); hrecur = subplot(2, 3, 4:5);
scatterBox(stay_prop_all(:,1), grps_all(:,1), 'xLabels', ...
    arrayfun(@num2str, 0:max_day_lag, 'UniformOutput', false), ...
    'yLabel', 'Prob. Stays Splitter', 'h', hstay);
xlabel('Lag (days)')
title('Splitters - all mice')
scatterBox(coactive_prop_all(:,1), grps_all(:,1), 'xLabels', ...
    arrayfun(@num2str, 0:max_day_lag, 'UniformOutput', false), ...
    'yLabel', 'Prob. Co-active', 'h', hrecur);
xlabel('Lag (days')

subplot(2,3,3)
[pkw_stay,~,stats_stay] = kruskalwallis(stay_prop_all(:,1), ...
    grps_all(:,1),'off');
text(0.1,0.5, ['pkw_{staysplit} = ' num2str(pkw_stay, '%0.2g')])
axis off

subplot(2,3,6)
[pkw_recur,~,stats_recur] = kruskalwallis(coactive_prop_all(:,1), ...
    grps_all(:,1), 'off');
text(0.1,0.5, ['pkw_{coactive} = ' num2str(pkw_recur, '%0.2g')])
axis off

% Plot and get stats for arm place fields
figure
set(gcf,'Position', [2000, 30, 1650, 890])
hstay = subplot(2, 3, 1:2); hrecur = subplot(2, 3, 4:5);
scatterBox(stay_prop_all(:,3), grps_all(:,3), 'xLabels', ...
    arrayfun(@num2str, 0:max_day_lag, 'UniformOutput', false), ...
    'yLabel', 'Prob. Stays Arm PC', 'h', hstay);
xlabel('Lag (days)')
title('Arm Place Cells - all mice')
scatterBox(coactive_prop_all(:,3), grps_all(:,3), 'xLabels', ...
    arrayfun(@num2str, 0:max_day_lag, 'UniformOutput', false), ...
    'yLabel', 'Prob. Co-active', 'h', hrecur);
xlabel('Lag (days')

subplot(2,3,3)
[pkw_stay,~,stats_stay] = kruskalwallis(stay_prop_all(:,1), ...
    grps_all(:,1),'off');
text(0.1,0.5, ['pkw_{staysplit} = ' num2str(pkw_stay, '%0.2g')])
axis off

subplot(2,3,6)
[pkw_recur,~,stats_recur] = kruskalwallis(coactive_prop_all(:,1), ...
    grps_all(:,1), 'off');
text(0.1,0.5, ['pkw_{coactive} = ' num2str(pkw_recur, '%0.2g')])
axis off

% NRK - return to the above when comparing place cell coactivity to
% splitter cells!!!

%% Splitter proportions for looping versus forced alternation versus free 
% Take home is that splitter proportion is almost entirely predicted by
% sesssion length, not performance or time. However, this also implies my
% measurements are a bit wonky since it seems like splitter detection
% depends on number of trials which implies it is a statistics issue.
% Instead, see next section to look at performance vs. "splittiness"
sesh_use = G30_alt;
grp_names = {'Free', 'Forced', 'Looping'};

[perf, split_prop,~, acclim_bool, forced_bool] = get_split_v_perf(sesh_use);
grps = ones(size(forced_bool)); % free alternation = 1
grps(acclim_bool) = 3; % looping = 3
grps(forced_bool) = 2; % forced = 2
figure; set(gcf,'Position',[600 540 810 260])
ha = subplot(1,2,1);
scatterBox(split_prop, grps, 'xLabels', grp_names(unique(grps)),...
    'yLabel', 'Proportion Splitters', 'h', ha)
make_plot_pretty(gca)

% Get stats for above
[pkw, ~, stats] = kruskalwallis(split_prop, grps,'off');
cmat = multcompare(stats, 'display', 'off');
subplot(1,2,2)
% Put names of all mice included here
text(0.1, 1.0, 'Mice included:')
text(0.1, 0.8, cellfun(@mouse_name_title, unique(arrayfun(@(a) a.Animal, ...
    sesh_use, 'UniformOutput', false)),'UniformOutput', false))
text(0.1, 0.4, 'g1   g2   \Delta_{LB}   \Delta_{est}   \Delta_{UB}   pval')
text(0.1, 0.2, num2str(cmat, '%0.2g \t'))
text(0.1, 0.1, ['pkw = ' num2str(pkw, '%0.2g')])
axis off


%% Save all the above.
[~, ~, ~, G30glmall] = plot_split_v_perf_batch(G30_alt);
printNK('G30 perf time ntrials v splitter proportion', 'alt')
[~, ~, ~, G31glmall] = plot_split_v_perf_batch(G31_alt);
printNK('G31 perf time ntrials v splitter proportion', 'alt')
[~, ~, ~, G45glmall] = plot_split_v_perf_batch(G45_alt);
printNK('G45 perf time ntrials v splitter proportion', 'alt')
[~, ~, ~, G48glmall] = plot_split_v_perf_batch(G48_alt);
printNK('G48 perf time ntrials v splitter proportion', 'alt')

[~, ~, ~, allmice_glmall] = plot_split_v_perf_batch(alt_all);
printNK('All Mice perf time ntrials v splitter proportion', 'alt')

%% Performance v splittiness
% add noise to corr curves to give L/R only neurons a value (otherwise they go to NaN).
inject_noise = true; 
trial_thresh = 20;
% halt = figure; set(gcf,'Position', [2130 440 960 460]);
for j = 1:4
    sesh_use = alt_all_cell{j};
    plot_perf_v_split_metrics(sesh_use, true, inject_noise, trial_thresh);
%     printNK(['Perf v split metrics - ' sesh_use(1).Animal],'alt')
end
%%
plot_perf_v_split_metrics(alt_all, true, inject_noise, trial_thresh);
printNK('Perf v split metrics - All Mice', 'alt')

% Do the above but eliminate G48 who might be carrying the team for the
% delta_max_norm metric
plot_perf_v_split_metrics(alt_all(~arrayfun(@(a) ...
    strcmpi(a.Animal,'GCaMP6f_48'),alt_all)), true, inject_noise, trial_thresh);
printNK('Perf v split metrics - No G48 with LDA', 'alt')

%% Breakdown above by individual mice - should probably do for different trial thresholds too

% Use alt_all_cell_sp to divide up G45 and G48 into early and late sessions
sesh_cell_use = alt_all_cell; 

% Pre-allocate mean performance and dnorm arrays
perf_mean = []; dnorm_mean = []; dint_mean = []; curve_corr_mean = [];
rely_mean = []; discr_perf_mean = [];

% Calculate values for each mouse
for j = 1:length(sesh_cell_use)
    split_metrics = plot_perf_v_split_metrics(sesh_cell_use{j}, ...
        false, inject_noise, trial_thresh);
    perf_mean = [perf_mean, nanmean(split_metrics.perf)];
    dnorm_mean = [dnorm_mean, nanmean(split_metrics.dmax_norm_mean)];
    dint_mean = [dint_mean, nanmean(split_metrics.dint_norm_mean)];
    curve_corr_mean = [curve_corr_mean, nanmean(split_metrics.curve_corr_mean)];
    rely_mean = [rely_mean, nanmean(split_metrics.rely_mean)];
    discr_perf_mean = [discr_perf_mean, nanmean(split_metrics.discr_perf)];
end

% Plot points
figure; set(gcf,'Position', [1964 157 1400 761]);
h1 = subplot(2,3,1); h2 = subplot(2,3,2); h3 = subplot(2,3,3);
h4 = subplot(2,3,4); h5 = subplot(2,3,5);

alt_group_plot_perf_v_split(h1, dnorm_mean, perf_mean, ...
    '|\Delta_{max}|_{norm}');
alt_group_plot_perf_v_split(h2, dint_mean, perf_mean, ...
    '\Sigma|\Delta|_{norm}');
alt_group_plot_perf_v_split(h3, curve_corr_mean, perf_mean, ...
    '\rho_{mean}');
alt_group_plot_perf_v_split(h4, rely_mean, perf_mean, ...
    'Reliability (1-p)');
alt_group_plot_perf_v_split(h5, discr_perf_mean, perf_mean, ...
    'Decoder (LDA) Accuracy (%)');
subplot(2,3,6);
text(0.1, 0.4, ['inject\_noise = ' num2str(inject_noise)])
text(0.1, 0.6, ['ntrial_thresh = ' num2str(split_metrics.trial_thresh)])
text(0.1, 0.8, ['nstem_thresh = ' num2str(split_metrics.nstem_thresh)])
axis off

% printNK('Perf v splittiness by mice','alt')

%% Run decoder analysis - needed before running the code above!
niters = 100; % num iterations
leave_out_prop = 0.5;
nshuf = 1000;

% Pre-allocate #animals x niters x nsesh x nbins_stem
tic
% corr_ratio_mean_all = nan(4, niters, length(sesh_use), 12); 
corr_ratio_mean_all = cell(1,4);
corr_ratio_mean_shuf_all = cell(1,4);
for n = 1:4
    sesh_use = alt_all_cell{n}; % Grab all sessions for one animal
    sesh_use = sesh_use(alt_get_sesh_type(sesh_use)); % Grab free sessions only
    hw = waitbar(0, ['Running LDA analysis for ' ...
        mouse_name_title(sesh_use(1).Animal) ' ...']); 
    corr_ratio_mean_all{n} = nan(length(sesh_use), 12, niters);
    corr_ratio_mean_shuf_all{n} = nan(length(sesh_use), 12, nshuf);
    for j = 1:length(sesh_use)
        LDAperf = nan(12,niters);
%         try
%             load(fullfile(sesh_use(j).Location,'LDAperf.mat'), 'LDAperf');
%         catch
            LDAperf_shuf = nan;
            for k = 1:niters
                % Correct ratio = average decoder performance along the whole stem
                
                try
                    if k == 1
                        [temp, LDAperf_shuf] = alt_LDA(sesh_use(j), ...
                            leave_out_prop, nshuf);
                    elseif k > 1 % Don't shuffle after 1st iteration
                        temp = alt_LDA(sesh_use(j), leave_out_prop, 0);
                    end
                catch
                    temp = nan;
                end
                
                LDAperf(:,k) = temp;
                waitbar(((j-1)*niters+k)/(niters*length(sesh_use)),hw);
            end
%         end
        corr_ratio_mean_all{n}(j,:,:) = LDAperf;
        corr_ratio_mean_shuf_all{n}(j,:,:) = LDAperf_shuf;
        save(fullfile(sesh_use(j).Location,'LDAperf_w_shuf.mat'), 'LDAperf',...
            'LDAperf_shuf', 'niters', 'nshuf', 'leave_out_prop');
        waitbar(j/length(sesh_use),hw);
        
    end
    close(hw);
end
toc

%% Now do above but downsample each mouse's sessions to match that of G31 or
% upsample/resample all the mice to match G48...
[alt_c_match_min, alt_c_match_max] = match_sesh_num(alt_all_cell);
plot_perf_v_split_metrics(cat(2,alt_c_match_min{:}));
plot_perf_v_split_metrics(cat(2,alt_c_match_max{:}));

%% Now do the above but shuffle everything and get a p-value for downsampling
% then plot distribution
nshuf = 1000;

hw = waitbar(0,'Downsampling and calculating perf v splittiness pvals');
pdown = nan(1,nshuf);
for j = 1:nshuf
    [alt_c_match_min, ~] = match_sesh_num(alt_all_cell);
    [~, ~, ptemp] = plot_perf_v_split_metrics(cat(2,alt_c_match_min{:}), ...
        false);    
    waitbar(j/nshuf, hw);
    pdown(j) = ptemp;
end
close(hw)


%% Related to above - Performance versus ntrials...
[alt_c_match_min, alt_c_match_max] = match_sesh_num(alt_all_cell);
alt_plot_perf_v_ntrials(cat(2,alt_c_match_min{:}))

