function [ rot_to_corr_to_std, rot_from_std] = get_rot_from_db(db_struct )
%  [rot_to_corr_to_std, rot_from_std] = get_rot_from_db(db_struct )
%   Takes a mouse database structure (from MakeMouseSessionList), looks at
%   the Notes section, and spits out the appropriate rotation that needs to
%   be applied to get the session back to the standard configuration.  e.g.
%   if the arena was rotated 90 degrees clockwise during the recording
%   (corresponding to a -90 degree rotation), the applied rotation to get
%   back to standard (rot_to_corr_to_std) would be 90.  Right hand rule
%   convention
%
%   rot_from_std is the opposite - e.g. if a session is rotated 90 degrees
%   CW, it spits out -90

% Complete partial db_struct
[~, db_struct] = ChangeDirectory(db_struct(1).Animal, db_struct(1).Date, ...
    db_struct(1).Session,0);

if isempty(db_struct(1).Notes)
    rot_to_corr_to_std = 0;
    rot_from_std = 0;
else
    if regexpi(db_struct(1).Notes,'90CW')
        rot_to_corr_to_std = 90;
        rot_from_std = 270;
    elseif regexpi(db_struct(1).Notes,'90CCW')
        rot_to_corr_to_std = -90;
        rot_from_std = 90;
    elseif regexpi(db_struct(1).Notes,'180')
        rot_to_corr_to_std = 180;
        rot_from_std = 180;
    else
        rot_to_corr_to_std = 0;
        rot_from_std = 0;
    end
end


end

