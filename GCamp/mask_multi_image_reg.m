function [] = mask_multi_image_reg(base_file, num_sessions, mask, varargin)
% mask_multi_image_reg(base_file, num_sessions, mask, ...)
%
%   Registers a base file to multiple recording sessions and saves these
%   registrations in a .mat file claled Reg_NeuronIDs.mat in your base file
%   directory. 
%
%   INPUTS:
%       base_file: Full file path of ICmovie_min_proj.tif to which you want
%       to register other sessions.
%
%       num_session: Number of sessions you want to register base_file to.
%       You will be prompted via gui to select this number of files for
%       registration
%
%       mask: the mask you wish to register to all the subsequent sessions
%       
%       OPTIONAL
%       'reg_files': this string, followed by a 1xn cell array with the
%       full path to the filenames of the sessions you want to register the, 
%       allows you to batch register the base mask to the sessions listed, 
%       and will place mask.mat in the folder containing the file
%       specified.  If not specified, you will be prompted to select each
%       of the files you want to register.
%       Example: mask_multi_image_reg(...,'reg_files',{'file1', 'file2',...})
%

%% Check for reg_file list
for j = 1:length(varargin)
    if strcmpi(varargin{j},'reg_files')
        reg_files = varargin{j+1};
        num_sessions = size(reg_files,2);
    end
end

%% Get base path.
base_path = fileparts(base_file);

%% Do the registrations.
%Preallocate.
reg_filename = cell(1,num_sessions);
reg_path = cell(1,num_sessions);
reg_date = cell(1,num_sessions);

%Select all the files first.
for this_session = 1:num_sessions
    if ~exist('reg_files','var')
        [reg_filename{this_session}, reg_path{this_session}] = uigetfile('*.tif', ['Pick file to register #', num2str(this_session), ': ']);
    else
        [reg_path{this_session}, name, ext] = fileparts(reg_files{this_session});
        reg_filename{this_session} = [name ext];
    end
    %Get date.
    date_format = ['(?<month>\d+)_(?<day>\d+)_(?<year>\d+)'];
    temp = regexp(reg_path{this_session},date_format,'names');
    reg_date{this_session} = [temp.month '-' temp.day '-' temp.year];
end

%Get base date.
temp = regexp(base_file,date_format,'names');
base_date = [temp.month '_' temp.day '_' temp.year];

%Get mouse name.
mouse_format = '(?<name>G\d+)';
mouse = regexp(base_file,mouse_format,'names');

%Get full file path.
reg_file = fullfile(reg_path, reg_filename);

%% Do the registrations.
for this_session = 1:num_sessions
    %Display.
    disp(['Registering ', base_date, ' to ', reg_date{this_session}, '...']);
    
    %Perform image registration. Note that this is backward from what
    %we usually do, as we are now taking the base file and registering
    %it to all the files in reg_file, not vice versa...
    reginfo_temp = image_registerX(reg_file{this_session}, ...
        base_file, 0);
    
    %Build the struct.
    mask_reg = imwarp(mask,reginfo_temp.tform,'OutputView',...
        reginfo_temp.base_ref,'InterpolationMethod','nearest');
    
    %Save the registered mask in the registered session file
    save (fullfile(reg_path{this_session},'mask_reg.mat'), 'mask_reg');
end
    
end