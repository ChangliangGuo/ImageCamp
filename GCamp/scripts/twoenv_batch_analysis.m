% Batch script for two-env experiment

%% Filtering variables
trans_rate_thresh = 0.005; % Hz
pval_thresh = 0.05; % don't include ANY TMaps with p-values above this
file_append = '_0_25cmperbin'; % If using archived PlaceMaps, this will be appended to the end of the Placemaps files

%% Set up mega-variable - note that working_dir 1 = square sessions and 2 = octagon sessions (REQUIRED)

Mouse(1).Name = 'G30';
Mouse(1).working_dirs{1} = 'J:\GCamp Mice\Working\G30\2env\11_19_2014\1 - 2env square left 201B\Working';
Mouse(1).working_dirs{2} = 'J:\GCamp Mice\Working\G30\2env\11_20_2014\1 - 2env octagon left\Working';

Mouse(2).Name = 'G31';
Mouse(2).working_dirs{1} = 'J:\GCamp Mice\Working\G31\2env\12_15_2014\1 - 2env square right\Working';
Mouse(2).working_dirs{2} = 'J:\GCamp Mice\Working\G31\2env\12_16_2014\1 - 2env octagon left\Working';

num_animals = length(Mouse);

for j = 1:num_animals
    Mouse(j).key = '1,1 = square no-rotate, 1,2 = octagon no-rotate, 2,1 = square rotate, 2,2 = octagon rotate';
end

%% Run tmap_corr_across_days for all conditions

for j = 1:num_animals
    for k = 1:length(Mouse(j).working_dirs)
        tt = tic;
        for m = 0:1
            [Mouse(j).corr_matrix{m+1,k}, pop_struct_temp, Mouse(j).pass_count{m+1,k},...
                Mouse(j).within_corr] = tmap_corr_across_days(Mouse(j).working_dirs{k},...
                'rotate_to_std',m,'population_corr',1,'trans_rate_thresh', ...
                trans_rate_thresh, 'pval_thresh',pval_thresh,...
                'archive_name_append',file_append,'within_session',1);
            Mouse(j).pop_corr_matrix{m+1,k} = pop_struct_temp.r;
        end
        disp(['tmap_corr_across_days took ' num2str(toc(tt)) ' seconds to run'])
    end
    Mouse(j).trans_rate_thresh = trans_rate_thresh;
end

%% Dump means into a mega-matrix (combine ALL correlation values here also to get a mega cdf for each session?)

num_sessions = size(Mouse(1).corr_matrix{1},1);
% mega_mean(1).matrix = cell(num_sessions,num_sessions); % No rotate
% mega_mean(2).matrix = cell(num_sessions,num_sessions); % rotate

% Get individual neuron mean correlation matrices
for ll = 1:num_sessions
    for mm = 1:num_sessions
        count = 1; % Start counter
        for j = 1:num_animals
            for k = 1:2
                mega_mean_rot_temp = nanmean(squeeze(Mouse(j).corr_matrix{2,k}(ll,mm,:)));
                mega_mean_no_rot_temp = nanmean(squeeze(Mouse(j).corr_matrix{1,k}(ll,mm,:)));
                
                mega_mean(1).matrix(ll,mm,count) = mega_mean_no_rot_temp; % [mega_mean(1).matrix(ll,mm) mega_mean_no_rot_temp];
                mega_mean(2).matrix(ll,mm,count) = mega_mean_rot_temp; % [mega_mean(2).matrix(ll,mm) mega_mean_rot_temp];
                count = count + 1;
            end
        end
    end
    
end

% Get population correlation matrices

for ll = 1:num_sessions
    for mm = 1:num_sessions
        count = 1; % Start counter
        for j = 1:num_animals
            for k = 1:2
                mega_mean_pop_rot_temp = Mouse(j).pop_corr_matrix{2,k}(ll,mm,:);
                mega_mean_pop_no_rot_temp = Mouse(j).pop_corr_matrix{1,k}(ll,mm,:);
                
                mega_mean(1).pop_matrix(ll,mm,count) = mega_mean_pop_no_rot_temp; % [mega_mean(1).matrix(ll,mm) mega_mean_no_rot_temp];
                mega_mean(2).pop_matrix(ll,mm,count) = mega_mean_pop_rot_temp; % [mega_mean(2).matrix(ll,mm) mega_mean_rot_temp];
                count = count + 1;
            end
        end
    end
end

%% Get basic stats - not done for population correlations yet

% Better way to do things in the future is to get values for ALL neuron correlations in
% each session and group them together somehow after classifying them due
% to the various comparisons below
mean_simple_norot = mean(mega_mean(1).matrix,3);
mean_simple_rot = mean(mega_mean(2).matrix,3);
if isnan(sum(mean_simple_rot(:))) || isnan(sum(mean_simple_norot(:)))
    disp('Note - some sessions have NO good correlations due to not meeting the threshold - be sure to check!')
    mean_simple_norot = nanmean(mega_mean(1).matrix,3);
    mean_simple_rot = nanmean(mega_mean(2).matrix,3);
end

mean_simple_pop_norot = mean(mega_mean(1).pop_matrix,3);
mean_simple_pop_rot = mean(mega_mean(2).pop_matrix,3);

% Indices for various comparisons - wow, that's a lot of work
before_win = [1 2 ; 1 3; 1 4; 2 3; 2 4; 3 4]; before_win_ind = sub2ind([8 8 4],before_win(:,1), before_win(:,2));
before_win_norot = [1 2; 1 4; 2 4; 3 4]; before_win_norot_ind = sub2ind([8 8 4],before_win(:,1), before_win(:,2));
after_win = [7 8]; after_win_ind = sub2ind([8 8 4],after_win(:,1), after_win(:,2));
after_win_norot = [7 8]; after_win_norot_ind = sub2ind([8 8 4],after_win_norot(:,1), after_win_norot(:,2));
before_after = [1 7; 2 7; 3 7; 4 7; 1 8; 2 8 ;3 8; 4 8]; before_after_ind = sub2ind([8 8 4],before_after(:,1), before_after(:,2));
before_after_norot = [2 7; 4 7; 1 8; 2 8 ; 3 8]; before_after_norot_ind = sub2ind([8 8 4],before_after_norot(:,1), before_after_norot(:,2));
before_5 = [1 5; 2 5; 3 5; 4 5]; before_5_ind = sub2ind([8 8 4],before_5(:,1), before_5(:,2));
before_5_norot = [2 5; 4 5]; before_5_norot_ind = sub2ind([8 8 4],before_5_norot(:,1), before_5_norot(:,2));
before_6 = [1 6; 2 6 ; 3 6; 4 6]; before_6_ind = sub2ind([8 8 4],before_6(:,1), before_6(:,2));
before_6_norot = [1 6; 2 6; 3 6; 4 6]; before_6_norot_ind = sub2ind([8 8 4],before_6_norot(:,1), before_6_norot(:,2));
after_5 = [5 7; 5 8]; after_5_ind = sub2ind([8 8 4],after_5(:,1), after_5(:,2));
after_5_norot = [5 8]; after_5_norot_ind = sub2ind([8 8 4],after_5_norot(:,1), after_5_norot(:,2));
after_6 = [6 7; 6 8]; after_6_ind = sub2ind([8 8 4],after_6(:,1), after_6(:,2));
after_6_norot = [6 7; 6 8]; after_6_norot_ind = sub2ind([8 8 4],after_6_norot(:,1), after_6_norot(:,2));

% Mean of individual correlations
before_win_mean = mean(mean_simple_rot(before_win_ind));
before_win_sem = std(mean_simple_rot(before_win_ind))/sqrt(length(before_win_ind));
before_win_norot_mean = mean(mean_simple_norot(before_win_norot_ind));
before_win_norot_sem = std(mean_simple_norot(before_win_norot_ind))/sqrt(length(before_win_norot_ind));

before_after_mean = mean(mean_simple_rot(before_after_ind));
before_after_sem = std(mean_simple_rot(before_after_ind))/sqrt(length(before_after_ind));
before_after_norot_mean = mean(mean_simple_norot(before_after_norot_ind));
before_after_norot_sem = std(mean_simple_norot(before_after_norot_ind))/sqrt(length(before_after_norot_ind));

before_5_mean = mean(mean_simple_rot(before_5_ind));
before_5_sem = std(mean_simple_rot(before_5_ind))/sqrt(length(before_5_ind));
before_5_norot_mean = mean(mean_simple_norot(before_5_norot_ind));
before_5_norot_sem = std(mean_simple_norot(before_5_norot_ind))/sqrt(length(before_5_norot_ind));

before_6_mean = mean(mean_simple_rot(before_6_ind));
before_6_sem = std(mean_simple_rot(before_6_ind))/sqrt(length(before_6_ind));
before_6_norot_mean = mean(mean_simple_norot(before_6_norot_ind));
before_6_norot_sem = std(mean_simple_norot(before_6_norot_ind))/sqrt(length(before_6_norot_ind));

after_5_mean = mean(mean_simple_rot(after_5_ind));
after_5_sem = std(mean_simple_rot(after_5_ind))/sqrt(length(after_5_ind));
after_5_norot_mean = mean(mean_simple_norot(after_5_norot_ind));
after_5_norot_sem = std(mean_simple_norot(after_5_norot_ind))/sqrt(length(after_5_norot_ind));
after_5_norot_sem = after_5_sem; % Fake it for now...only have one sample currently

after_6_mean = mean(mean_simple_rot(after_6_ind));
after_6_sem = std(mean_simple_rot(after_6_ind))/sqrt(length(after_6_ind));
after_6_norot_mean = mean(mean_simple_norot(after_6_norot_ind));
after_6_norot_sem = std(mean_simple_norot(after_6_norot_ind))/sqrt(length(after_6_norot_ind));

% Mean of population correlations
pop_before_win_mean = mean(mean_simple_pop_rot(before_win_ind));
pop_before_win_sem = std(mean_simple_pop_rot(before_win_ind))/sqrt(length(before_win_ind));
pop_before_win_norot_mean = mean(mean_simple_pop_norot(before_win_norot_ind));
pop_before_win_norot_sem = std(mean_simple_pop_norot(before_win_norot_ind))/sqrt(length(before_win_norot_ind));

pop_before_after_mean = mean(mean_simple_pop_rot(before_after_ind));
pop_before_after_sem = std(mean_simple_pop_rot(before_after_ind))/sqrt(length(before_after_ind));
pop_before_after_norot_mean = mean(mean_simple_pop_norot(before_after_norot_ind));
pop_before_after_norot_sem = std(mean_simple_pop_norot(before_after_norot_ind))/sqrt(length(before_after_norot_ind));

pop_before_5_mean = mean(mean_simple_pop_rot(before_5_ind));
pop_before_5_sem = std(mean_simple_pop_rot(before_5_ind))/sqrt(length(before_5_ind));
pop_before_5_norot_mean = mean(mean_simple_pop_norot(before_5_norot_ind));
pop_before_5_norot_sem = std(mean_simple_pop_norot(before_5_norot_ind))/sqrt(length(before_5_norot_ind));

pop_before_6_mean = mean(mean_simple_pop_rot(before_6_ind));
pop_before_6_sem = std(mean_simple_pop_rot(before_6_ind))/sqrt(length(before_6_ind));
pop_before_6_norot_mean = mean(mean_simple_pop_norot(before_6_norot_ind));
pop_before_6_norot_sem = std(mean_simple_pop_norot(before_6_norot_ind))/sqrt(length(before_6_norot_ind));

pop_after_5_mean = mean(mean_simple_pop_rot(after_5_ind));
pop_after_5_sem = std(mean_simple_pop_rot(after_5_ind))/sqrt(length(after_5_ind));
pop_after_5_norot_mean = mean(mean_simple_pop_norot(after_5_norot_ind));
pop_after_5_norot_sem = std(mean_simple_pop_norot(after_5_norot_ind))/sqrt(length(after_5_norot_ind));
pop_after_5_norot_sem = pop_after_5_sem; % Fake it for now...only have one sample currently

pop_after_6_mean = mean(mean_simple_pop_rot(after_6_ind));
pop_after_6_sem = std(mean_simple_pop_rot(after_6_ind))/sqrt(length(after_6_ind));
pop_after_6_norot_mean = mean(mean_simple_pop_norot(after_6_norot_ind));
pop_after_6_norot_sem = std(mean_simple_pop_norot(after_6_norot_ind))/sqrt(length(after_6_norot_ind));

% Plot individual neuron means
figure(10)
h = bar([before_win_mean, before_win_norot_mean; before_after_mean, before_after_norot_mean; ...
    before_5_mean, before_5_norot_mean; after_5_mean, after_5_norot_mean; ...
    before_6_mean, before_6_norot_mean; after_6_mean, after_6_norot_mean]);
hold on
errorbar(h(1).XData + h(1).XOffset, [before_win_mean, before_after_mean, ...
    before_5_mean, after_5_mean, before_6_mean, after_6_mean], [before_win_sem, ...
    before_after_sem, before_5_sem, after_5_sem, before_6_sem, after_6_sem],...
    '.')
errorbar(h(2).XData + h(2).XOffset, [before_win_norot_mean, before_after_norot_mean, ...
    before_5_norot_mean, after_5_norot_mean, before_6_norot_mean, after_6_norot_mean], [before_win_norot_sem, ...
    before_after_norot_sem, before_5_norot_sem, after_5_norot_sem, before_6_norot_sem, after_6_norot_sem],...
    '.')
set(gca,'XTickLabel',{'Before within','Before-After','Before-Day5','After-Day5',...
    'Before-Day6','After-Day6'})
ylabel('Transient Map Mean Correlations - Individual Neurons')
legend('Rotated (local cues align)','Not-rotated (distal cues align)')
hold off

% Plot population correlation summary
figure(11)
h = bar([pop_before_win_mean, pop_before_win_norot_mean; pop_before_after_mean, pop_before_after_norot_mean; ...
    pop_before_5_mean, pop_before_5_norot_mean; pop_after_5_mean, pop_after_5_norot_mean; ...
    pop_before_6_mean, pop_before_6_norot_mean; pop_after_6_mean, pop_after_6_norot_mean]);
hold on
errorbar(h(1).XData + h(1).XOffset, [pop_before_win_mean, pop_before_after_mean, ...
    pop_before_5_mean, pop_after_5_mean, pop_before_6_mean, pop_after_6_mean], [pop_before_win_sem, ...
    pop_before_after_sem, pop_before_5_sem, pop_after_5_sem, pop_before_6_sem, pop_after_6_sem],...
    '.')
errorbar(h(2).XData + h(2).XOffset, [pop_before_win_norot_mean, pop_before_after_norot_mean, ...
    pop_before_5_norot_mean, pop_after_5_norot_mean, pop_before_6_norot_mean, pop_after_6_norot_mean], [pop_before_win_norot_sem, ...
    pop_before_after_norot_sem, pop_before_5_norot_sem, pop_after_5_norot_sem, pop_before_6_norot_sem, pop_after_6_norot_sem],...
    '.')
set(gca,'XTickLabel',{'Before within','Before-After','Before-Day5','After-Day5',...
    'Before-Day6','After-Day6'})
ylabel('Transient Map Mean Population Correlations')
legend('Rotated (local cues align)','Not-rotated (distal cues align)')
hold off




%% Get example plots of rotated versus non-rotated correlation histograms and hopefully example neurons

centers = -0.2:0.05:0.9;
figure
subplot(2,2,1)
hist(squeeze(Mouse(1).corr_matrix{1,2}(3,4,:)),centers);
title('Histogram between sessions that are NOT rotated (distal cues align)')
xlabel('Calcium Transient Heat Map Correlation'); ylabel('Count')

subplot(2,2,2)
hist(squeeze(Mouse(1).corr_matrix{2,2}(3,4,:)),centers);
title('Histogram between sessions rotated such that local cues align')
xlabel('Calcium Transient Heat Map Correlation'); ylabel('Count')

subplot(2,2,3)
ecdf(squeeze(Mouse(1).corr_matrix{1,2}(3,4,:))); 
hold on; 
ecdf(squeeze(Mouse(1).corr_matrix{2,2}(3,4,:)))
legend('NOT-rotated data (distal cues align)','Rotated data (local cues align)',...
    'Location','SouthEast')
title('Empirical CDF of correlation values between sessions')
xlabel('Calcium Transient Heat Map Correlation (x)');

%% Example plots of correlations < 0, and high ones

load('j:\GCamp Mice\Working\G30\2env\11_21_2014\1 - 2env octagon mid 201B\Working\PlaceMaps.mat','TMap','TMap_gauss')
TMaps_norot{3} = TMap_gauss;
load('j:\GCamp Mice\Working\G30\2env\11_21_2014\2 - 2env octagon left 90CW 201B\Working\PlaceMaps.mat','TMap','TMap_gauss')
TMaps_norot{4} = TMap_gauss;
load('j:\GCamp Mice\Working\G30\2env\11_21_2014\1 - 2env octagon mid 201B\Working\PlaceMaps_rot_to_std.mat','TMap','TMap_gauss')
TMaps_rot{3} = TMap_gauss;
load('j:\GCamp Mice\Working\G30\2env\11_21_2014\2 - 2env octagon left 90CW 201B\Working\PlaceMaps_rot_to_std.mat','TMap','TMap_gauss')
TMaps_rot{4} = TMap_gauss;
load('J:\GCamp Mice\Working\G30\2env\11_20_2014\1 - 2env octagon left\Working\batch_session_map.mat');

highcorrs_ind = find(squeeze(Mouse(1).corr_matrix{2,2}(3,4,:)) > 0.8);
lowcorrs_ind = find(squeeze(Mouse(1).corr_matrix{1,2}(3,4,:)) < 0.2);

j = 1; 
for j = 1:length(highcorrs_ind)
figure(50); 
row = highcorrs_ind(j); 
subplot(1,2,1); imagesc(TMaps_rot{3}{batch_session_map.map(row,4)}); 
title(['Neuron ' num2str(batch_session_map.map(row,4)) ...
    ' w/Correlation = ' num2str(Mouse(1).corr_matrix{2,2}(3,4,row))]);
subplot(1,2,2); imagesc(TMaps_rot{4}{batch_session_map.map(row,5)});
title(['Neuron ' num2str(batch_session_map.map(row,5))])

waitforbuttonpress

end

for j = 1:length(lowcorrs_ind)
figure(50); 
row = lowcorrs_ind(j); 
subplot(1,2,1); imagesc(TMaps_norot{3}{batch_session_map.map(row,4)}); 
title(['Neuron ' num2str(batch_session_map.map(row,4)) ...
    ' w/Correlation = ' num2str(Mouse(1).corr_matrix{1,2}(3,4,row))]);
subplot(1,2,2); imagesc(TMaps_norot{4}{batch_session_map.map(row,5)});
title(['Neuron ' num2str(batch_session_map.map(row,5))])

waitforbuttonpress

end

%% Attempt to get population correlations...




