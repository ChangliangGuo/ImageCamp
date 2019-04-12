function [ perf_calc, perf_notes, perf_by_trial, num_trials ] = alt_get_perf( MD )
% [perf_calc, perf_notes, perf_by_trial] = alt_get_perf( MD )
%   gets performance data on alternation task for all sessions indicated in
%   MD. perf_calc pulls data from Will's automated trial parsing code,
%   perf_notes pulls it directly from the notes in MD.

perf_notes = nan(length(MD),1);
perf_calc = nan(length(MD),1);
perf_by_trial = cell(length(MD),1);
num_trials = nan(length(MD),1);
for j = 1:length(MD)
    [dirstr,sesh_use] = ChangeDirectory_NK(MD(j),0);
    try
        perf_notes(j) = sesh_use.perf/100;
    catch
        disp(['No perf field found in MD for ' MD(j).Animal ' ' ...
            MD(j).Date ' session ' num2str(MD(j).Session)])
    end
    
    try
        load(fullfile(dirstr,'Alternation.mat'), 'Alt');
        num_correct = sum(Alt.summary(:,3));
        num_trials(j) = size(Alt.summary,1);
        perf_calc(j) = num_correct/num_trials(j);
        perf_by_trial{j} = Alt.summary(:,3);
    catch
        disp(['No Alternation.mat file found for ' MD(j).Animal ' ' ...
            MD(j).Date ' session ' num2str(MD(j).Session)])
    end
end

