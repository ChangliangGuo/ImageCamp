function [ perf, split_prop, split_num, acclim_bool, forced_bool ] = ...
    get_split_v_perf( MD )
%  [ perf, split_prop, split_num, valid_bool, forced_bool ] = ...
%     get_split_v_perf( MD )
%  Gets performance, splitter proportion, splitter number, acclimation
%  sessions, and forced sessions for later plotting

num_sessions = length(MD);
%% Get performance for each session
MD = complete_MD(MD); % Add in all data if not there already

[perf_calc, perf_notes] = alt_get_perf(MD);
perf = nanmean([perf_calc, perf_notes],2); % Change this when you debug/check all auto calculated sessions

% Get acclimation/forced sessions
[ ~, acclim_bool, forced_bool ] = alt_get_sesh_type( MD );

%% Get prop splitters
split_num = zeros(num_sessions,1);
split_prop = zeros(num_sessions,1);
for j = 1:num_sessions
    load(fullfile(MD(j).Location,'sigSplitters.mat'),'numSplitters',...
        'tuningcurves');
    split_num(j) = numSplitters;
    split_prop(j) = numSplitters/length(tuningcurves);
end

end

