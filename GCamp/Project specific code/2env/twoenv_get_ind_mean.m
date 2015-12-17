function [ local_stat, distal_stat, both_stat ] = twoenv_get_ind_mean(Mouse_struct, local_sub_use, distal_sub_use, varargin )
% [ local_stat, distal_stat, both_stat ] = twoenv_get_ind_mean(Mouse_struct, local_sub_use, distal_sub_use, varargin )
% Takes Mouse_struct and pulls out all the appropriate correlations whose
% subs are listed in local_sub_use, distal_sub_use, and optionally
% both_sub_use.
%
%   local_sub_use, distal_sub_use, both_use_sub: either a nx2 or nx3 array with the last
%   two columns being the pointers to the session comparison (e.g. [5 8] or
%   [1 5 8] compares the 5th session to the 8th session).  If there are 3
%   columns then the 1st column designates which arena to look at (1 =
%   square, 2 = octagon).  If there are only two columns then it will look
%   at the same sessions in both the square and the circle.  Number of
%   columns must be consistent across all

%% Initialize variables and get varargins
temp_local = [];
temp_distal = [];
temp_both = []; both_sub_use = [];
for j = 1:length(varargin)
   if strcmpi(varargin{j},'both_sub_use')
       both_sub_use = varargin{j+1};
   end
end

%% Check if arena type is specified in the vectors - if not, then add it in

local_sub_use = check_indices_type(local_sub_use);
distal_sub_use = check_indices_type(distal_sub_use);
both_sub_use = check_indices_type(both_sub_use);

%% Create _stat variables

distal_stat = calc_group_stats(Mouse_struct, distal_sub_use,1);
local_stat = calc_group_stats(Mouse_struct, local_sub_use, 2);

if ~isempty(both_sub_use)
    both_stat = calc_group_stats(Mouse_struct, both_sub_use,1);
else
    both_stat = [];
end

% for k = 1:length(Mouse_struct)
%     for j = 1:2
%             local_indices_use = make_mega_sub2ind(size(Mouse_struct(k).corr_matrix{loca_indices,j}),...
%                 local_sub_use(:,1),local_sub_use(:,2));
%             distal_indices_use = make_mega_sub2ind(size(Mouse_struct(k).corr_matrix{1,j}),...
%                 distal_sub_use(:,1),distal_sub_use(:,2));
%             
%             temp_distal = [temp_distal; Mouse_struct.corr_matrix{1,j}(distal_indices_use)];
%             temp_local = [temp_local; Mouse_struct.corr_matrix{2,j}(local_indices_use)];
%             
%             if ~isempty(both_sub_use)
%                both_indices_use = make_mega_sub2ind(size(Mouse_struct(k).corr_matrix{1,j}),...
%                    both_sub_use(:,1),both_sub_use(:,2));
%                temp_both = [temp_both; Mouse_struct.corr_matrix{2,j}(both_indices_use)];
%             end
%     end
% end
% 
% local_stat.all = temp_local;
% local_stat.mean = nanmean(temp_local);
% local_stat.sem = nanstd(temp_local)/sqrt(length(local_indices_use));
% 
% distal_stat.all = temp_distal;
% distal_stat.mean = nanmean(temp_distal);
% distal_stat.sem = nanstd(temp_distal)/sqrt(length(distal_indices_use));
% 
% if isempty(both_sub_use)
%     both_stat = [];
% else
%     both_stat.all = temp_both;
%     both_stat.mean = nanmean(temp_both);
%     both_stat.sem = nanstd(temp_both)/sqrt(length(both_indices_use));
% end
    
end

%% sub-function to check indices
function [indices_fix] = check_indices_type(indices_in)
%%
num_comparisons = size(indices_in,1);
if size(indices_in,2) == 2
    indices_fix = zeros(2*num_comparisons,3);
    indices_fix(1:num_comparisons,1) = ones(num_comparisons,1);
    indices_fix(num_comparisons + 1:end,1) = 2*ones(num_comparisons,1);
    indices_fix(:,2:3) = repmat(indices_in,2,1);
else
    indices_fix = indices_in;
end
%%
end

%% sub-fuction to get correlations out and calculate mean/sem
function [stat_use] = calc_group_stats(animal_struct, sub_use, local_flag)
% local_flag: 1 = use distal aligned comparisons, 2 = use local aligned
% comparisons
all_out = [];
all_means = [];
temp = [];
num_comparisons = size(sub_use,1);
for k = 1:length(animal_struct)
    for j = 1:2
        for arena_use = 1:2
            sub_use_index = sub_use(arena_use == sub_use(:,1)); % Pull-out subs for appropriate arena
            indices_use = make_mega_sub2ind(size(animal_struct(k).corr_matrix{arena_use,j}),...
                sub_use(sub_use_index,2),sub_use(sub_use_index,3)); % convert subs to indices
            
            temp = animal_struct(k).corr_matrix{local_flag,j}(indices_use);
            all_out = [all_out; temp]; % Add appropriate comparisons into temp_out
            all_means = [all_means; nanmean(temp)];
        end
    end
end

stat_use.all = all_out;
stat_use.all_means = all_means;
stat_use.mean = nanmean(all_out);
stat_use.sem = nanstd(all_out)/sqrt(num_comparisons);

end

