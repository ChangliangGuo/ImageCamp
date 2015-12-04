function [ xtrans, ytrans ] = circ2square( xpos_circ, ypos_circ, square_side, circle_radius )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% Parameters

kc = circle_radius; % cm
ks = square_side/2; % pi()*kc/2; % cm
R_c = kc;

%% Transform circle cartesian data to polar coordinates

% First center everything
[fx, x] = ecdf(xpos_circ);
[fy, y] = ecdf(ypos_circ);
xmid = (x(find(fx > 0.95,1,'first')) + x(find(fx < 0.05,1,'last')))/2;
ymid = (y(find(fy > 0.95,1,'first')) + y(find(fy < 0.05,1,'last')))/2;

xcent = xpos_circ - xmid;
ycent = ypos_circ - ymid;

% Get polar coordinates
r_c = sqrt(xcent.^2 + ycent.^2);
theta = atan2(ycent,xcent);

%% Transform circle polar cooridnates to square polar coorinates

% Get square radius
r_s = zeros(size(theta));
for j = 1:length(theta)
    if theta(j) < -3*pi/4 || (-pi/4 < theta(j) & theta(j) < pi/4) || (3*pi/4 < theta(j) & theta(j) < 5*pi/4)
        R_s(j) = ks*sqrt(1 + tan(theta(j))^2);
    else
        R_s(j) = ks*sqrt(1 + 1/tan(theta(j))^2);
    end
    
end

r_cprime = r_c.*R_s/R_c;

%% Transform square polar to cartesian
xtrans = r_cprime.*cos(theta);
ytrans = r_cprime.*sin(theta);

end
