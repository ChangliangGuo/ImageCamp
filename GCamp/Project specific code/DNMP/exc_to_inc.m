function [ include_log, include_ind ] = exc_to_inc( exclude_ind, num_frames)
% [include_log, include_ind]  = exc_to_inc( exclude_ind, num_frames)
%  output of DNMP_parse_trials (frames to exclude) and creates a
% logical of frames to include for later plotting as well as indices to
% include
%   exc_ind are indices of frames to exclude for plotting, num_frames is
%   the total number of frames to plot

temp = false(1,num_frames);
temp(exclude_ind) = true;
include_log = ~temp;
include_ind = find(include_log);

end

