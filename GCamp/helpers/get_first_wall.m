function [ wall_degree] = get_first_wall( x,y, square_bool )
% [wall_degree, wall_ord] = get_first_wall( x,y, square_bool )
%   Find the 1st wall the mouse goes to in an open field. wall_degree
%   starts at 0 for the east wall follows the RHR (e.g. north wall = 90,
%   west = 180, south = 270); Spits out things in 90 degree increments if
%   square_bool is set to true (default = false);

if nargin < 3
    square_bool = false;
end

wall_thresh = 0.05;

% Skeleton code that should work
% 1) Use boundary function to get boundaries of data
% 2) Get the range of the data to get an idea of the arena size
% 3) Tag the 1st time he gets within 0.05*range of one wall
% 4) Spit out the orientation of that point by calculating direction from the center
% of the arena, and if in a square, also spit out that in 90 degree increments


% None of this works unless it is a square!!!
% [fx, xx] = ecdf(x);
% [fy, xy] = ecdf(y);
% first_touch = find(x < xx(findclosest(fx,wall_thresh)) | x > xx(findclosest(fx,1-wall_thresh)) ...
%     | y < xy(findclosest(fy,wall_thresh)) | y > xy(findclosest(fy,1-wall_thresh)),...
%     1,'first'); % Get frame of 1st touch
% 
% xm = mean(x); ym = mean(y);
% 
% if square_bool
%     if find(x < xx(findclosest(fx,wall_thresh)),1,'first') == first_touch
%         wall_degree = 180;
%     elseif find(x > xx(findclosest(fx,1-wall_thresh)),1,'first') == first_touch
%         wall_degree = 0;
%     elseif find(y < xy(findclosest(fy,wall_thresh)),1,'first') == first_touch
%         wall_degree = 270;
%     elseif find(y > xx(findclosest(fy,1-wall_thresh)),1,'first') == first_touch
%         wall_degree = 90;
%     end
% elseif ~square_bool
    

end

