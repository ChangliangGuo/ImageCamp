%% Set-up everything
twoenv_reference;

Mouse(1).sesh.square = G30_square;
Mouse(1).sesh.circle = G30_oct;
Mouse(1).sesh.circ2square = G30_botharenas;
Mouse(1).best_angle.square = G30_square_best_angle;
Mouse(1).best_angle.circle = G30_circle_best_angle;
Mouse(1).best_angle.circ2square = G30_both_best_angle;

Mouse(2).sesh.square = G31_square;
Mouse(2).sesh.circle = G31_oct;
Mouse(2).sesh.circ2square = G31_botharenas;
Mouse(2).best_angle.square = G31_square_best_angle;
Mouse(2).best_angle.circle = G31_circle_best_angle;
Mouse(2).best_angle.circ2square = G31_both_best_angle;

Mouse(3).sesh.square = G45_square;
Mouse(3).sesh.circle = G45_oct;
Mouse(3).sesh.circ2square = G45_botharenas;
Mouse(3).best_angle.square = G45_square_best_angle;
Mouse(3).best_angle.circle = G45_circle_best_angle;
Mouse(3).best_angle.circ2square = G45_both_best_angle;

Mouse(4).sesh.square = G48_square;
Mouse(4).sesh.circle = G48_oct;
Mouse(4).sesh.circ2square = G48_botharenas;
Mouse(4).best_angle.square = G48_square_best_angle;
Mouse(4).best_angle.circle = G48_circle_best_angle;
Mouse(4).best_angle.circ2square = G48_both_best_angle;

days.square = square_days;
days.circle = circle_days;
days.circ2square = all_days;

days_diff.square = 0:6;
days_diff.circle = 0:6;
days_diff.circ2square = [0:5 7];

num_animals = length(Mouse);

animal_names = cell(1,num_animals);
for j = 1:num_animals
    animal_names{j} = Mouse(j).sesh.square(1).Animal;
end
    
% P-value thresholds for cell inclusion
pval_filt = false;
pval_thresh = 1;
cmperbin_use = 4; 
ntrans_thresh = 1;
num_shuffles =1000;

inclusion_criteria.pval_filt = pval_filt;
inclusion_criteria.pval_thresh = pval_thresh;
inclusion_criteria.cmperbin_use = cmperbin_use;
inclusion_criteria.ntrans_thresh = ntrans_thresh;

sesh_type = {'square', 'circle', 'circ2square'};

%% Calc PVs w/o silent cell, with all silent cells, and with only non-ambiguous
% silent cells. square only to start
silent_thresh = [nan 0 1];
same_bool = [true true false];
local_aligned = [false true];
tic
basedir = ChangeDirectory_NK(G30_square(1),0);
for pp = 1 %1:2 % 1 is at optimal rotation, 2 is at local cue rotation
    if pp == 1
        nshuf = num_shuffles;
        sil_thresh_use = silent_thresh;
        animal_start = 1;
    elseif pp == 2
        nshuf = 0;
        sil_thresh_use = silent_thresh;
        animal_start = 1;
    end
    for j = animal_start:num_animals
        for m = 1:3 % square, circ, circ2square
            for k = 1:2 % length(silent_thresh) % 1:3 silenthresh = nan, 0, or 1
                
                sesh_use = Mouse(j).sesh.(sesh_type{m});
                best_angle_use = Mouse(j).best_angle.(sesh_type{m});
                f = tic;
                [PVcorrs, PVshuf_corrs, ~, ~, PV, filter] = twoenv_PVbatch(sesh_use, best_angle_use, ...
                    same_bool(m), nshuf, sil_thresh_use(k), pval_thresh,...
                    ntrans_thresh, local_aligned(pp), cmperbin_use);
                toc(f);
                Mouse(j).PVcorrs.(sesh_type{m})(k).PV = PV;
                Mouse(j).PVcorrs.(sesh_type{m})(k).PVcorrs = PVcorrs;
                Mouse(j).PVcorrs.(sesh_type{m})(k).PVshuf_corrs = PVshuf_corrs;
                Mouse(j).PVcorrs.(sesh_type{m})(k).silent_thresh = sil_thresh_use(k);
                Mouse(j).PVcorrs.(sesh_type{m})(k).pval_thresh = pval_thresh;
                Mouse(j).PVcorrs.(sesh_type{m})(k).ntrans_thresh = ntrans_thresh;
                Mouse(j).PVcorrs.(sesh_type{m})(k).local_aligned = local_aligned(pp);
                Mouse(j).PVcorrs.(sesh_type{m})(k).cmperbin = cmperbin_use;
                Mouse(j).PVcorrs.(sesh_type{m})(k).filter = filter;
                
            end
        end
    end
    savename = fullfile(basedir,['2env_PVsilent_cm' num2str(cmperbin_use) '_local' ...
        num2str(local_aligned(pp)) '-' num2str(num_shuffles) ...
        'shuffles-' datestr(now,29) '.mat']);
    save(savename,'Mouse','-v7.3')
end
disp(['PV analysis at best rotation angle ran in ' num2str(toc,'%0.0g') ' seconds'])
% savename = ['2env_PVsilent_' num2str(num_shuffles) 'shuffles-' datestr(now,29) '.mat'];
% save(savename,'Mouse','-v7.3')

%% Calc PVs w/o silent cell, with all silent cells, and with only non-ambiguous
% silent cells. square only to start
silent_thresh = [nan 0 1];
same_bool = [true true false];
local_aligned = [false true];
tic
basedir = ChangeDirectory_NK(G30_square(1),0);
for pp = 2 %1:2 % 1 is at optimal rotation, 2 is at local cue rotation
    if pp == 1
        nshuf = num_shuffles;
        sil_thresh_use = silent_thresh;
        animal_start = 2;
    elseif pp == 2
        nshuf = 0;
        sil_thresh_use = silent_thresh;
        animal_start = 1;
    end
    for j = animal_start:num_animals
        for m = 1:3 % square, circ, circ2square
            for k = 1:length(sil_thresh_use) % 1:3 silenthresh = nan, 0, or 1
                
                sesh_use = Mouse(j).sesh.(sesh_type{m});
                best_angle_use = Mouse(j).best_angle.(sesh_type{m});
                f = tic;
                [PVcorrs, PVshuf_corrs, ~, ~, PV, filter] = twoenv_PVbatch(sesh_use, best_angle_use, ...
                    same_bool(m), nshuf, sil_thresh_use(k), pval_thresh,...
                    ntrans_thresh, local_aligned(pp), cmperbin_use);
                toc(f);
                Mouse(j).PVcorrs.(sesh_type{m})(k).PV = PV;
                Mouse(j).PVcorrs.(sesh_type{m})(k).PVcorrs = PVcorrs;
                Mouse(j).PVcorrs.(sesh_type{m})(k).PVshuf_corrs = PVshuf_corrs;
                Mouse(j).PVcorrs.(sesh_type{m})(k).silent_thresh = sil_thresh_use(k);
                Mouse(j).PVcorrs.(sesh_type{m})(k).pval_thresh = pval_thresh;
                Mouse(j).PVcorrs.(sesh_type{m})(k).ntrans_thresh = ntrans_thresh;
                Mouse(j).PVcorrs.(sesh_type{m})(k).local_aligned = local_aligned(pp);
                Mouse(j).PVcorrs.(sesh_type{m})(k).cmperbin = cmperbin_use;
                Mouse(j).PVcorrs.(sesh_type{m})(k).filter = filter;
                
            end
        end
    end
    savename = fullfile(basedir,['2env_PVsilent_cm' num2str(cmperbin_use) '_local' ...
        num2str(local_aligned(pp)) '-' num2str(num_shuffles) ...
        'shuffles-' datestr(now,29) '.mat']);
    save(savename,'Mouse','-v7.3')
end
disp(['PV analysis at best rotation angle ran in ' num2str(toc,'%0.0g') ' seconds']);
%%
sesh_use = all_sessions;
for j = 1:length(sesh_use)
%     Placefields(sesh_use(j),'minspeed',1,'Pos_data','Pos_align.mat');
    PlacefieldStats(sesh_use(j));
%     Placefields(sesh_use(j),'minspeed',1,'name_append','_rot_to_std','Pos_data','Pos_align_std_corr.mat');
    PlacefieldStats(sesh_use(j),'name_append','_rot_to_std');
end
%%
sesh_use = G48_oct;
limits_use = logical(G48_manual_limits);
batch_align_pos(sesh_use(1), sesh_use(2:end), 'auto_rotate_to_std',0,...
    'manual_limits', limits_use);
batch_align_pos(sesh_use(1), sesh_use(2:end), 'auto_rotate_to_std',1,...
    'manual_limits', limits_use);

%%
sesh_use = G48_square;
for j = 1:length(sesh_use)
    dirstr = ChangeDirectory(sesh_use(j).Animal, sesh_use(j).Date, sesh_use(j).Session);
    load(fullfile(dirstr,'Placefields.mat'),'TMap_unsmoothed','RunOccMap','PSAbool');
    spatInfo(TMap_unsmoothed,RunOccMap,PSAbool,true);
    load(fullfile(dirstr,'Placefields_rot_to_std.mat'),'TMap_unsmoothed','RunOccMap','PSAbool');
    spatInfo(TMap_unsmoothed,RunOccMap,PSAbool,true,'name_append','_rot_to_std');
end

%% Run Placefields_half
sesh_use = cat(2,G30_botharenas(9:12));

for j = 1
    [~, MD_use] = ChangeDirectory_NK(sesh_use(j),0);
    Placefields_half( MD_use, 'half', MD_use.exclude_frames, '_rot_to_std', 'Pos_data','Pos_align_std_corr.mat');
    Placefields_half( MD_use, 'half', MD_use.exclude_frames, '', 'Pos_data','Pos_align.mat');
    
end

%% tmap_corr_across_days debugging

figure(25)
for j = 1:50
    n2_use = map1_2_shuffle(j);
    if n2_use == 0
        continue
    else
        subplot(1,2,1);
        imagesc(sesh(k).TMap{j});
        title(num2str(j));
        subplot(1,2,2)
        imagesc(sesh(ll).TMap{n2_use});
        title(num2str(n2_use))
    waitforbuttonpress
    end
                  
                    
end

%% Two-env rotation analysis
sesh_use = G48_oct([1, 3:4]);
limits_use = G48_manual_limits([1, 3:4]);
rot_array_use = 0:15:345; % for circle % 0:90:270; % for square
adjust_base = false; % true = start from scratch, false = leave base sessions alone, only adjust registered sessions
batch_rot_arena(sesh_use(1), sesh_use(2:end), rot_array_use, logical(limits_use),...
    'base_adjust', adjust_base);

%% GC above
figure(35)
n = 1;
rot_check = [90]; %[90 270]; % 
[dirstr, ~]  = ChangeDirectory_NK(sesh_use(1),0);
load(fullfile(dirstr,'Pos_align_rot0.mat'),'xmin','xmax','ymin','ymax');
for j = 1:length(sesh_use)
    
    [dirstr, temp]  = ChangeDirectory_NK(sesh_use(j),0);
    for k = 1:length(rot_check)
        ax(n) = subplot(4,6,n);
        load(fullfile(dirstr,['Pos_align_rot' num2str(rot_check(k)) '.mat']),'x_adj_cm','y_adj_cm','xmin','xmax','ymin','ymax');
        plot(x_adj_cm, y_adj_cm)
        xlabel(temp.Env)
        title([mouse_name_title(temp.Date ) ' - session ' num2str(temp.Session)])
        n = n + 1;
        xlim([xmin xmax]); ylim([ymin ymax])
    end

            
end
linkaxes(ax);

%% Run immediately after above - run square or circle PF analysis on aligned data
cmperbin_use = 4;
sesh_use = all_square; % all_oct; % G30_square(1); %all_square; %all_oct; % all_sessions
rot_array_use = 0:90:270; %0:15:345; %
if cmperbin_use ~= 1; cm_append = ['_cm' num2str(cmperbin_use)]; else ; cm_append = ''; end
tic
for j = 1:length(sesh_use)
    disp(['Running Rotated Placefield Analysis on ' sesh_use(j).Animal ' - ' sesh_use(j).Date ' - session ' num2str(sesh_use(j).Session)])
    [~,sesh_full] = ChangeDirectory_NK(sesh_use(j),0); % fill in partial struct
    for k = 1:length(rot_array_use)
        name_append_full = [cm_append '_rot' num2str(rot_array_use(k))];
        Placefields(sesh_full,'minspeed',1,'name_append', name_append_full,...
            'Pos_data', ['Pos_align_rot' num2str(rot_array_use(k)) '.mat'], ...
            'exclude_frames', sesh_full.exclude_frames, 'cmperbin', cmperbin_use);
        PlacefieldStats(sesh_use(j),'name_append', name_append_full);

    end
end
toc

%% two-env circle-to-square comparison - NOTE MAY NEED TO CORRECT G30 limits for this and RE-RUN all PFs!
sesh_use = cat(2,G48_square(1), G48_oct(1:4)); limits_use = G48_both_manual_limits([1 3 4 5 6]);
rot_array = 0:15:345;
adjust_base = false; % true = start from scratch, false = leave base sessions alone, only adjust registered sessions
batch_rot_arena(sesh_use(1), sesh_use(2:end), rot_array, logical(limits_use),...
    'circ2square', true, 'base_adjust', adjust_base);

%% Make batch_session_map if not done already
neuron_reg_batch(sesh_use(1), sesh_use(2:end), 'name_append', '_trans');

%% QC above
sesh_use = G48_botharenas;
figure(35)
n = 1;
rot_check = [45 330];
[dirstr, temp]  = ChangeDirectory_NK(sesh_use(1),0);
load(fullfile(dirstr,'Pos_align_trans_rot0.mat'),'xmin','xmax','ymin','ymax');
for j = 1:length(sesh_use)
    
    [dirstr, temp]  = ChangeDirectory_NK(sesh_use(j),0);
    if ~isempty(regexpi(temp.Env,'octagon'))
        for k = 1:2
            ax(n) = subplot(4,6,n);
            load(fullfile(dirstr,['Pos_align_trans_rot' num2str(rot_check(k)) '.mat']),'x_adj_cm','y_adj_cm');
            plot(x_adj_cm, y_adj_cm)
            xlabel(temp.Env)
            title([mouse_name_title(temp.Date ) ' - session ' num2str(temp.Session)])
            n = n + 1;
            xlim([xmin xmax]); ylim([ymin ymax])
        end
    elseif ~isempty(regexpi(temp.Env,'square'))
        ax(n) = subplot(4,6,n);
        load(fullfile(dirstr,'Pos_align_trans_rot180.mat'),'x_adj_cm','y_adj_cm');
        plot(x_adj_cm, y_adj_cm)
        xlabel(temp.Env)
        title([mouse_name_title(temp.Date) ' - session ' num2str(temp.Session)])
        n = n+1;
        xlim([xmin xmax]); ylim([ymin ymax])
    end
            
end
linkaxes(ax);

%% Double check you've copied over all the appropriate old Placefield files before
% running the below
sesh_use = G48_botharenas;
archive_log = false(1,length(sesh_use));
curr_dir = cd;
for j = 1:length(sesh_use)
    ChangeDirectory_NK(sesh_use(j));
    cd('old placefields without MI')
    temp = ls;
    archive_log(j) = (size(temp,1) >= 6);
end
cd(curr_dir);

%% Run immediately after above
sesh_use = all_sessions; %cat(2,G31_square(1),G31_oct(1)); % cat(2, G45_square(2:end), G48_square, G30_square, G31_square);
cmperbin_use = 4;
rot_array_circle = 0:15:345;
rot_array_square = 0:90:270;
run_win_too = false; % true = run square only and circle only too!
if cmperbin_use ~= 1; cm_append = ['_cm' num2str(cmperbin_use)]; else ; cm_append = ''; end
for j = 7; %1:length(sesh_use)
    [dirstr, full_sesh] = ChangeDirectory(sesh_use(j).Animal, sesh_use(j).Date, sesh_use(j).Session);
    disp(['Running Circle2Square Rotated Placefield Analysis on ' full_sesh.Animal ...
        ' - ' full_sesh.Date ' - session ' num2str(full_sesh.Session)])
    
    if ~isempty(regexpi(full_sesh.Env,'octagon'))
        rot_array_use = rot_array_circle;
    elseif ~isempty(regexpi(full_sesh.Env,'square'))
        rot_array_use = rot_array_square;
    end
    
    
    for k = length(rot_array_use) %1:length(rot_array_use)
        name_append_full = [cm_append '_trans_rot' num2str(rot_array_use(k))];
        Placefields(full_sesh,'minspeed',1,'name_append', name_append_full,...
            'Pos_data', ['Pos_align_trans_rot' num2str(rot_array_use(k))],...
            'cmperbin', cmperbin_use, 'exclude_frames', full_sesh.exclude_frames);
        PlacefieldStats(full_sesh,'name_append',name_append_full);
    end
    
    if run_win_too % Run within square or within circle sessions too!
        disp(['Running ' full_sesh.Env ' Analysis'])
        Placefields(full_sesh,'minspeed',1,'name_append', name_append_full,...
            'Pos_data', ['Pos_align_rot' num2str(rot_array_use(k)) '.mat'], ...
            'exclude_frames',full_sesh.exclude_frames, 'cmperbin', cmperbin_use);
        PlacefieldStats(full_sesh,'name_append',name_append_full);
    end
end

%% Run on connected sessions for each half at best angle only
sesh_use = cat(2,G30_botharenas(9:12),G31_botharenas(9:12),G45_botharenas(9:12),...
    G48_botharenas(9:12));
cmperbin_use = 4;
rot_array = cat(2,G30_both_best_angle(9:12), G31_both_best_angle(9:12),...
    G45_both_best_angle(9:12),G48_both_best_angle(9:12));
run_win_too = false; % true = run square only and circle only too!
if cmperbin_use ~= 1; cm_append = ['_cm' num2str(cmperbin_use)]; else ; cm_append = ''; end
for j = 1:length(sesh_use)
    [dirstr, full_sesh] = ChangeDirectory(sesh_use(j).Animal, sesh_use(j).Date, ...
        sesh_use(j).Session);
    disp(['Running Circle2Square Rotated Placefield Analysis on ' full_sesh.Animal ...
        ' - ' full_sesh.Date ' - session ' num2str(full_sesh.Session)])
    
    rot_array_use = rot_array(j);
    name_append_full = ['_half' cm_append '_trans_rot' num2str(rot_array_use)];
    Placefields_half(full_sesh,'inMD', full_sesh.exclude_frames, name_append_full,...
        'minspeed',1,'Pos_data', ['Pos_align_trans_rot' num2str(rot_array_use)],...
        'cmperbin', cmperbin_use);
    PlacefieldStats(full_sesh,'name_append',[name_append_full '_inMD'],...
        'halfPF',true);
    
end

%% Fix batch_align_pos
sesh_use = G31_botharenas;

%% Plot TMaps for all arenas with ideally aligned rotations
sesh_use = G45_botharenas;
rot_array_use = G45_both_best_angle;
trans = false;

base_dir = ChangeDirectory(sesh_use(1).Animal, sesh_use(1).Date, ...
    sesh_use(1).Session, 0);
load(fullfile(base_dir,'batch_session_map_trans.mat'));
batch_map = batch_session_map;

disp('Loading TMaps for all sessions')
num_sessions = length(sesh_use);
num_neurons = size(batch_session_map.map,1);
TMap_rot = cell(1,num_sessions);
for j = 1:num_sessions
    dirstr = ChangeDirectory(sesh_use(j).Animal, sesh_use(j).Date, ...
        sesh_use(j).Session, 0);
    if ~isempty(regexpi(dirstr,'oct')) && trans 
        load(fullfile(dirstr,['Placefields_trans_rot' num2str(rot_array_use(j)) '.mat']),'TMap_gauss');
    elseif ~isempty(regexpi(dirstr,'square')) || (~isempty(regexpi(dirstr,'oct')) && ~trans)
        load(fullfile(dirstr,['Placefields_rot' num2str(rot_array_use(j)) '.mat']),'TMap_gauss');
    end
    TMap_rot{j} = TMap_gauss;
end

figure
cm = colormap('jet');
TMap_nada = nan(size(TMap_rot{1}{1}));
% TMap_nada(~isnan(TMap_rot{1}{1})) = 0;
for j = 1:num_neurons
    for k = 1:num_sessions
        neuron_use = batch_session_map.map(j,k+1);
        subplot_auto(num_sessions,k);
        if ~isnan(neuron_use) && neuron_use ~= 0
           imagesc_nan(TMap_rot{k}{neuron_use}, cm, [1 1 1]);
           title(num2str(k))
        else
            imagesc_nan(TMap_nada, cm, [1 1 1]);
        end
    end
    waitforbuttonpress
end

%% Add in all rotations to square sessions to circ2square alignments
sesh_use = G31_square;
manual_limits = G31_manual_limits;
rot_array = 90:90:270;
reg_sesh_full = sesh_use(1);
man_limits_full = [];
name_append_full = cell(1,length(sesh_use)*length(rot_array)+1);
name_append_full{1} = '_trans_rot0'; %'_rot0';
rot_full = [];
n = 1;
for j = 1:length(sesh_use)
    rot_to_std = get_rot_from_db(sesh_use(j));
    for k = 1:length(rot_array)
        reg_sesh_full(n) = sesh_use(j);
        man_limits_full(n) = manual_limits_use(j);
        rot_full(n) = rot_array(k) + rot_to_std;
        name_append_full{n+1} = ['_trans_rot' num2str(rot_array(k))]; % '_rot'
        n = n + 1;
    end
end

%%% NRK - need to add in the appropriate value for each of the parameters
%%% above to make it the appropriate length
man_limits_full = logical([manual_limits(1) man_limits_full]);
rot_full = [0 rot_full];
rot_full(rot_full >= 360) = rot_full(rot_full >= 360) - 360;

batch_align_pos(sesh_use(1), reg_sesh_full,'skip_skew_fix', true, 'rotate_data', rot_full,...
    'manual_limits', man_limits_full, 'name_append', name_append_full, ...
    'suppress_output', true, 'skip_trace_align', true, 'base_adjust', false);

%% Get halfway point for each connected sessions
sesh_use = G31_square(5:6 );
figure; 
curr_dir = cd;
for j = 1:length(sesh_use)
    [dirstr, MD_use] = ChangeDirectory_NK(sesh_use(j));
    load(fullfile(dirstr,'FinalOutput.mat'),'PSAbool');
    x = AlignImagingToTracking(MD_use.Pix2CM,PSAbool,0);
    plot(x);
    title([mouse_name_title(MD_use.Animal) ' ' mouse_name_title(MD_use.Date)]);
    keyboard
end
cd(curr_dir)

%% Run PF_half for each mouse on connected days
sesh_use = cat(2,G30_square(5:6),G30_oct(5:6),G31_square(5:6),G31_oct(5:6));

for j = 1:length(sesh_use)
    [dirstr, MD_use] = ChangeDirectory_NK(sesh_use(j));
    Placefields_half( MD_use, 'half', MD_use.exclude_frames, '','half_custom',...
        MD_use.half, 'Pos_data','Pos_align_rot0.mat');
end

%% Run full rotation analysis for each mouse/comparison type
% close all
tic
sesh_type = {'square', 'circle', 'circ2square'};
num_shuffles = 1000;
rot_array_use = {0:90:270, 0:15:345, 0:15:345};
incr_use = [90, 15, 15];
plot_comb = true;
alpha = 0.05; % significance level
cm_append = '_cm4';
TMap_append = 'unsmoothed';
TMap_type = ['TMap_' TMap_append];

% Pre-allocate figure axes
if plot_comb
    for j = 1:3
        hcomb(j) = figure(40+j);
    end
end

for mm = 1:num_animals
    Animal_use = Mouse(mm);
    sessions{1} = Animal_use.sesh.square;
    sessions{2} = Animal_use.sesh.circle;
    sessions{3} = Animal_use.sesh.circ2square;
    % Run analysis and save individual plots for each comparison
    for j = 1:length(sesh_type)
        file_save_name = [Animal_use.sesh.(sesh_type{j})(1).Animal ...
            ' - Combined Tuning Curves - ' sesh_type{j} cm_append TMap_append...
            ' - ' num2str(num_shuffles) ' shuffle'];

        htemp = twoenv_squeeze(Animal_use.global_remap_stats.(sesh_type{j}).h_remap);
        sig_value = twoenv_squeeze(Animal_use.global_remap_stats.(sesh_type{j}).p_remap);
        sig_star = ~isnan(htemp) & htemp ~= 1;
        [~, best_angle_all, ~, ~, corr_means, CI, hh, best_angle_shuf_all] = ...
            twoenv_rot_analysis_full(sessions{j}, sesh_type{j}, 'save_fig', ...
            true, 'num_shuffles', num_shuffles,...
            'sig_star', sig_star, 'sig_value', sig_value,...
            'cm_append',cm_append,'TMap_type',TMap_type);
        close(hh)
        
        % Plot combined curve and save
        gr_remap_log = ~isnan(Animal_use.remapping_type.global.(sesh_type{j})) & ...
            (Animal_use.remapping_type.global.(sesh_type{j}) ~= 0);
        if plot_comb
            h2 = twoenv_plot_full_rot(corr_means, rot_array_use{j}, gr_remap_log, ...
                'CI', CI);
            printNK(file_save_name, '2env_rot')
            close(h2);
        end

        if plot_comb
            twoenv_plot_full_rot(corr_means, rot_array_use{j}, gr_remap_log, ...
                'CI', CI, 'h', hcomb(j)); % Combine all mice for each sesh_type
        end
        
        % Plot rotation difference
        rotd_save_name = [Animal_use.sesh.(sesh_type{j})(1).Animal ...
            ' - Rot Diffs - ' sesh_type{j} ' - ' num2str(num_shuffles) ' shuffle'];
%         coh_sig = Mouse(mm).global_remap_stats.(sesh_type{j}).h_remap;
%         coh_sig(~isnan(coh_sig)) = ~coh_sig(~isnan(coh_sig));
        num_comps = sum(~cellfun(@isempty, best_angle_all(:))); % number of comparisons
        p_mat = calc_coherency2(best_angle_all, best_angle_shuf_all, sesh_type{j}, 1);
        coh_sig = p_mat < alpha/num_comps;
        [rotd, h3] = twoenv_plot_rotd(best_angle_all, incr_use(j), coh_sig, true);
        subplot(8,8,1); title([mouse_name_title(sessions{j}(1).Animal) ' - ' sesh_type{j}])
        set(h3,'PaperPositionMode','auto', 'PaperOrientation','landscape',...
            'PaperType', 'arch-b')
%         keyboard
        printNK(rotd_save_name,'2env_rot','')
        close(h3);

%         close(hh); close(h2); close(h3);
    end
end

if plot_comb
    for j = 1:3
        file_save_name = ['All Mice - Combined Tuning Curves - ' sesh_type{j} ...
            cm_append TMap_append ' - ' num2str(num_shuffles) ' shuffle'];
        figure(hcomb(j))
        printNK(file_save_name,'2env_rot')
    end
end
toc

%% Plot PVcorrs between arenas before, during, after for all mice
% Looking for local changes in PV near hallway - don't really see
% anything...
PVcorrb_all = []; PVcorrd_all = []; PVcorra_all = [];
figure(300);
for k = 1:num_animals
    
    % Before
    PVcorrb = []; 
    for j = 1:4
        PVcorrb = cat(3,PVcorrb,squeeze(Mouse(k).PV_corrs.circ2square.PV_corr(...
            square_sesh(j),circ_sesh(j),:,:))); 
    end
    
    % During
    PVcorrd = []; 
    for j = 5:6
        PVcorrd = cat(3,PVcorrd,squeeze(Mouse(k).PV_corrs.circ2square.PV_corr(...
            square_sesh(j),circ_sesh(j),:,:))); 
    end
    
    % After
    PVcorra = [];
    for j = 7:8
        PVcorra = cat(3,PVcorra,squeeze(Mouse(k).PV_corrs.circ2square.PV_corr(...
            square_sesh(j),circ_sesh(j),:,:)));
    end
    subplot(5,3,3*(k-1)+1)
    imagesc_nan(nanmean(PVcorrb,3)); colorbar
    subplot(5,3,3*(k-1)+2)
    imagesc_nan(nanmean(PVcorrd,3)); colorbar
    subplot(5,3,3*(k-1)+3)
    imagesc_nan(nanmean(PVcorra,3)); colorbar
    
    PVcorrb_all = cat(3,PVcorrb_all,PVcorrb);
    PVcorrd_all = cat(3,PVcorrd_all,PVcorrd);
    PVcorra_all = cat(3,PVcorra_all,PVcorra);

end

subplot(5,3,13)
imagesc_nan(nanmean(PVcorrb_all,3)); colorbar
subplot(5,3,14)
imagesc_nan(nanmean(PVcorrd_all,3)); colorbar
subplot(5,3,15)
imagesc_nan(nanmean(PVcorra_all,3)); colorbar

%% Messing around with re-running PV analysis with pval thresh

[PVpthresh2,PVcorrs_thresh2] = get_PV_and_corr(G30_square,batch_session_map,...
    'use_TMap','unsmoothed','TMap_name_append', arrayfun(@(a) ['_cm4_rot' num2str(a)],...
    G30_square_best_angle,'UniformOutput',false),'filter_type', 'pval');

%%
% Tenaspis2_profile('GCamp6f_45','08_05_2015',3,'PF_only',1,'calc_half',1)
% Tenaspis2_profile('GCamp6f_45','08_05_2015',3,'PF_only',1,'calc_half',2)
% Tenaspis2_profile('GCamp6f_45','08_05_2015',4,'PF_only',1,'calc_half',1)
% Tenaspis2_profile('GCamp6f_45','08_05_2015',4,'PF_only',1,'calc_half',2)
% Tenaspis2_profile('GCamp6f_45','08_11_2015',1,'PF_only',1,'calc_half',1)
% Tenaspis2_profile('GCamp6f_45','08_11_2015',1,'PF_only',1,'calc_half',2)

%% Testing out hypothesis from Law, Bulkin, and Smith (2016) that there is more
% instability in early sessions that late ones
load('J:\GCamp Mice\Working\G30\2env\11_19_2014\1 - 2env square left 201B\Working\2env_batch_analysis4_workspace_1000shuffles_2018JAN11.mat');
subs_use = [1 2; 3 4; 7 8];
square_all = nan(4,3); circle_all = nan(4,3); 
for j = 1:4
    squarePV = Mouse(j).PV_corrs.active_both.square.PV_corr_mean;
    circlePV = Mouse(j).PV_corrs.active_both.circle.PV_corr_mean;
    square_all(j,:) = squarePV(sub2ind([8,8], subs_use(:,1),...
        subs_use(:,2)));
    circle_all(j,:) = circlePV(sub2ind([8,8], subs_use(:,1),...
        subs_use(:,2)));
end

sq_days = repmat([1 3 5],4,1);
ci_days = repmat([2 4 6],4,1);
combPV_sameday = cat(1,square_all,circle_all);
days_all = cat(1,sq_days, ci_days);
days_all2 = repmat(1:3,8,1);

try close(28); catch; end
figure(28); set(gcf,'Position',[420 420 420 420]); h = gca;
scatterBox(combPV_sameday(:),days_all2(:),'xLabels',{'SQ/CIR1','SQ/CIR2','SQ/CIR3'},...
    'yLabel','|\rho_{PV}|','transparency',0.7,'h',h);
make_plot_pretty(gca);
printNK('Same Arena Stability vs Days','2env','append', true)
[p,t,ss] = anova1(combPV_sameday(:),days_all2(:),'off');
[cc,mm,hh] = multcompare(ss,'display','off');
pos_use = get(gcf,'Position');
try close(29); catch; end
figure(29); set(gcf,'Position',[420 420 420 420]);
text(0.1,0.7,['pANOVA = ' num2str(p)])
text(0.1,0.5,['c12 = ' num2str(cc(1,6),'%0.2g')])
text(0.1,0.3,['c13 = ' num2str(cc(2,6),'%0.2g')])
text(0.1,0.1,['c12 = ' num2str(cc(3,6),'%0.2g')])
axis off
printNK('Same Arena Stability vs Days','2env','append', true)

%% Now add in days 5 and 6 to the picture - not quite apples-to-apples since
% you are comparing 2 - 5 min sessions in each arena, but allright for
% starters.  Better would be to make PVs from 1st half of each session on
% days 1-4 and 7-8, and compare sesh1_1st to sesh2_1st, and sesh1_2nd to
% sesh2_2nd on each day, but that's too much work for now for a question
% that's pretty tangential to the story.
%
% Result supports data from Law, Bulkin, and Smith (2016).  Lower PV corrs
% on SQ/CIR1 turn into consistently high values on SQ/CIR2 and SQ/CIR3.
% Arena Connection introduces interference that reduces PV correlations on
% connected days.
load('J:\GCamp Mice\Working\G30\2env\11_19_2014\1 - 2env square left 201B\Working\2env_PV_conn_1000shuffles-2018-01-17.mat')

square_comb = nan(4,2); circle_comb = nan(4,2);
for j = 1:4
    PVconn_use = Mouse(j).PV_corrs.conn.pval.PV_corr_mean;
    square_comb(j,:) = PVconn_use(sub2ind([8,8],[1 6],[3,8]));
    circle_comb(j,:) = PVconn_use(sub2ind([8,8],[2 5],[4,7]));
end

PVcomb_all = cat(1,cat(2,square_all,square_comb),cat(2,circle_all,circle_comb));
days_all_comb = repmat([1 2 5 3 4],8,1);

try close(30); catch; end;
figure(30); set(gcf,'Position',[420 420 550 420]); h = gca;
scatterBox(PVcomb_all(:),days_all_comb(:),'xLabels',...
    {'SQ/CIR1','SQ/CIR2','CONN1','CONN2','SQ/CIR3'},...
    'yLabel','|\rho_{PV}|','transparency',0.7,'h',h);
make_plot_pretty(gca);
printNK('Same Arena Stability vs Days - With Conn Days','2env','append', true)
[p,t,ss] = anova1(PVcomb_all(:),days_all_comb(:),'off');
[cc,mm,hh] = multcompare(ss,'display','off');
pos_use = get(gcf,'Position');
try close(31); catch; end
figure(31); set(gcf,'Position',[420 420 550 420]);
text(0.1,0.7,['pANOVA = ' num2str(p)])
text(0.1,0.5,['c12 = ' num2str(cc(1,6),'%0.2g')])
text(0.1,0.3,['c13 = ' num2str(cc(2,6),'%0.2g')])
text(0.1,0.1,['c12 = ' num2str(cc(3,6),'%0.2g')])
axis off
printNK('Same Arena Stability vs Days - With Conn Days','2env','append', true)

%% Save only neuron image from FinalOutput.mat

for j = 1:64
    ChangeDirectory_NK(all_sessions(j))
    load('FinalOutput.mat','NeuronImage')
    save('NeuronROIs','NeuronImage')
end

%% same as below but for coherency between sessions - run before below
plot_flag = false;
for j = 1:4; try close(600+j); end; end

% pairs = [9 10; 9 9; 9 10; 10 9; 10 10; 9 10; ...
%     11 12; 11 11; 11 12; 12 11; 12 12; 11 12];
pairs = [9 10; 9 9; 9 10; 9 10; 10 10; 9 10; ...
    12 11; 11 11; 12 11; 12 11; 12 12; 12 11];
% halves = [1 1; 1 2; 1 2; 2 1; 1 2; 2 2; ...
%     1 1; 1 2; 1 2; 1 2; 2 1; 2 2];
halves = [1 1; 1 2; 1 2; 2 1; 1 2; 2 2; ...
    1 1; 1 2; 2 1; 1 2; 1 2; 2 2];
sub_use = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4; ...
    5 6; 5 7; 5 8; 6 7; 6 8; 7 8];

n = 1;
coh_bool_conns = cell(4,8,8);
neuron_id_conns = cell(4,8,8);
dmean_conns = nan(4,8,8);
hw = waitbar(0,'Doing pairwise delta\_angle plots for coherency by half...');
disp('Doing pairwise delta_angle plots for coherency by half...')
for j = 1:4
    if plot_flag; figure(600+j); end
    for k = 1:size(pairs,1)
%         [~, ~, ~, ~, ~, ~, coh_bool_conns{j,index_use(k,1), index_use(k,2)},...
%             neuron_id_conns{j,index_use(k,1), index_use(k,2)}] = ...
%             plot_delta_angle_hist(all_sessions2(j,pairs(k,1)), ...
%             all_sessions2(j,pairs(k,2)), all_sessions2(j,1), 'circ2square', true, ...
%             'half_use', halves(k,:), 'plot_flag', false, 'bin_size', ...
%             '_half_cm1_speed1_inMD');
    if plot_flag
        h = subplot(3,4,k);
    else
        h = [];
    end
        
        [~, dmean_use, ~, ~, ~, ~, coh_bool_conns{j,sub_use(k,1), sub_use(k,2)},...
            neuron_id_conns{j,sub_use(k,1), sub_use(k,2)}] = ...
            plot_delta_angle_hist(all_sessions2(j,pairs(k,1)), ...
            all_sessions2(j,pairs(k,2)), [], 'circ2square', true, ...
            'half_use', halves(k,:), 'plot_flag', plot_flag, 'bin_size', ...
            '_half_cm1_speed1_inMD', 'coh_ang_thresh', 30, 'h', h);
        dmean_conns(j,sub_use(k,1), sub_use(k,2)) = dmean_use;
        if plot_flag; ylabel(['dmean = ' num2str(round(dmean_use,0))]); end
        waitbar(n/4/size(pairs,1),hw);
        n = n + 1;
    end
end
close(hw)

dmean_conns_exact = dmean_conns;
dmean_temp = dmean_conns;
dmean_temp = round(dmean_temp/15)*15;
dmean_temp(dmean_temp == 360) = 0;
dmean_conns = dmean_temp;

dmean_conns_rev = nan(4,8,8);
dmean_conns_rev(~isnan(dmean_conns)) = 360 - dmean_conns(~isnan(dmean_conns));
dmean_conns_rev(dmean_conns_rev == 360) = 0;

%% Run pairwise PVcorrs for all connected sessions without regard to rotation...
ntrans_thresh = 5;

PVconns_filt = cell(4,8,8);
PVconns_all = cell(4,8,8);
filt_all = cell(4,8,8);

n = 1;
hw = waitbar(0,'Doing pairwise PVcorrs by half...');
disp('Doing pairwise PVcorrs by half');
for j = 1:4
    for k = 1:size(pairs,1)
        % Old way using best rotation for WHOLE session
%         [~, PV1use, PV2use, final_filt, PV1, PV2] = pairwise_PVcorr(all_sessions2(j,pairs(k,1)), ...
%             all_sessions2(j,pairs(k,2)), 'PFname_append', ...
%             {['_half_cm4_trans_rot' num2str(all_best_ang2_rev(j,pairs(k,1))) '_forPV_inMD'], ...
%             ['_half_cm4_trans_rot' num2str(all_best_ang2_rev(j,pairs(k,2))) '_forPV_inMD']}, ...
%             'half_use',halves(k,:), 'silent_thresh', 0, 'pval_thresh', 1, ...
%             'ntrans_thresh', 1);
        % New way using best rotation between each half...
        rot_use = dmean_conns_rev(j, sub_use(k,1), sub_use(k,2));
        [~, PV1use, PV2use, final_filt, PV1, PV2] = pairwise_PVcorr(all_sessions2(j,pairs(k,1)), ...
            all_sessions2(j,pairs(k,2)), 'PFname_append', ...
            {['_half_cm4_trans_rot' num2str(0) '_forPV_inMD'], ...
            ['_half_cm4_trans_rot' num2str(rot_use) '_forPV_inMD']}, ...
            'half_use', halves(k,:), 'silent_thresh', 0, 'pval_thresh', 1, ...
            'ntrans_thresh', ntrans_thresh);
        
        PVconns_filt{j,sub_use(k,1), sub_use(k,2)} = cat(4,PV1use,PV2use);
        PVconns_all{j,sub_use(k,1), sub_use(k,2)} = cat(4,PV1,PV2);
        filt_all{j,sub_use(k,1), sub_use(k,2)} = final_filt;
        waitbar(n/4/size(pairs,1),hw);
        n = n+1;
    end
end
close(hw)

% Save the above two
save(fullfile(ChangeDirectory_NK(G30_square(1),0), ['2env_PVdiscrimination_' ...
    datestr(now,29) '.mat']),'PVconns_filt','PVconns_all','filt_all',...
    'coh_bool_conns','neuron_id_conns', 'dmean_conns', 'dmean_conns_rev')
    

%% Run placefields_half for connected sessions but rotate things correctly!
% Should run BEFORE running the above!!!!

all_best_ang2_rev = 360-all_best_ang2;
all_best_ang2_rev(all_best_ang2_rev == 360) = 0;

for j = 1:4
    for k = 9:12
        ang_rot = all_best_ang2_rev(j,k);
        Placefields_half(all_sessions2(j,k), 'inMD', [], ...
            ['_half_cm4_trans_rot' num2str(ang_rot) '_forPV'], 'minspeed', 1, 'cmperbin', ...
            4, 'Pos_data', ['Pos_align_trans_rot' num2str(ang_rot) '.mat'],...
            'B',1)
    end
end

%% Same as above but for each pair independently
for j = 1:4
    for k =  1:size(pairs,1)
        ang_rot = dmean_conns_rev(j, sub_use(k,1), sub_use(k,2));
        Placefields_half(all_sessions2(j,pairs(k,2)), 'inMD', [], ...    
            ['_half_cm4_trans_rot' num2str(ang_rot) '_forPV'], 'minspeed', 1, 'cmperbin', ...
            4, 'Pos_data', ['Pos_align_trans_rot' num2str(ang_rot) '.mat'],...
            'B',1)
    end
end

%%
for j = 1:4
    for k = 10:11
        Placefields_half(all_sessions2(j,k), 'inMD', [], ...    
            ['_half_cm4_trans_rot' num2str(0) '_forPV'], 'minspeed', 1, 'cmperbin', ...
            4, 'Pos_data', ['Pos_align_trans_rot' num2str(0) '.mat'],...
            'B',1)
    end
end

        
        