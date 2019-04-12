function [ ha, stay_prop, coactive_prop, cat_names, coactive_bool] = ...
    alt_stability_v_cat(MDbase, MDreg, varargin)
% [ha, stay_prop, coactive_prop] = alt_stability_v_cat( MDbase, MDreg, ... )
%   Gets and plots two cell stability metrics: coactivity probability, and probability of
%   staying in the same category vs category for alternation task (stem 
%   place cells (PCs), stem non-place cells (NPCs), splitters, non-stem PCs, 
%   and non-stem NPCs. set name-value pair 'plot_flag' to false to just
%   spit out stability metrics. 
%
%   stay_prop and coactive_prop are ordered as follows: [splitters, armPCs,
%       armNPCs stemPCs stemNPCs num_trans < ntrans_thresh]

sesh = complete_MD(MDbase);
sesh(2) = complete_MD(MDreg);
%% Parse Inputs
ip = inputParser;
ip.addRequired('MDbase',@isstruct);
ip.addRequired('MDreg',@isstruct);
ip.addParameter('PFname', 'Placefields.mat', @ischar);
ip.addParameter('pval_thresh',0.05,@(a) a > 0 & a <= 1);
ip.addParameter('ntrans_thresh',5 ,@(a) a >= 0);
ip.addParameter('sigthresh', 3, @(a) a >= 1); % specify minimum number of signicant splitting bins required to be considered a splitter
ip.addParameter('coactive_only', false, @islogical);
ip.addParameter('ha', [], @ishandle);
ip.addParameter('plot_flag',true,@islogical);
ip.addParameter('matchER', false, @islogical); % true = match event-rate between all categories
ip.parse(MDbase,MDreg,varargin{:});

PFname = ip.Results.PFname;
pval_thresh = ip.Results.pval_thresh;
ntrans_thresh = ip.Results.ntrans_thresh;
sigthresh = ip.Results.sigthresh;
coactive_only = ip.Results.coactive_only;
ha = ip.Results.ha;
plot_flag = ip.Results.plot_flag;
matchER = ip.Results.matchER;

%% Step 1: register sessions
% Get map and cells that go silent or become active
neuron_map = neuron_map_simple(MDbase, MDreg,'suppress_output', true);

%% Step 2: Parse cells into splitters (1), stem PCs(2), stem NPCs (3), 
% arm PCs(4) ,and arm NPCs(5), 0 = doesn't pass ntrans threshold

[categories, ~, temp] = arrayfun(@(a) alt_parse_cell_category(a, pval_thresh, ...
    ntrans_thresh, sigthresh, PFname), sesh, 'UniformOutput', false);
cat_names = temp{1};
%% Step 3: Get category stability metrics

% Eliminate low event-rate (ER) neurons to roughly match event rates between all
% categories
if matchER
    load(fullfile(MDbase.Location,PFname),'PSAbool');
    ntrans = get_num_trans(PSAbool);
    trans_range = 5:max(ntrans); % get #trans
    split_mean = mean(ntrans(categories{1} == 1));
    
    % adjust all the other thresholds
    for j = 2:5
        catmeans = arrayfun(@(a) mean(ntrans(ntrans > a & categories{1} == j)), ...
            trans_range); % get mean ER at each transient threshold
        
        % Get ntrans threshold to use for ER matching
        cat_nthresh = trans_range(find(catmeans > split_mean,1,'first'));
        
        % dump any neurons that don't meet threshold for each category to
        % nans
        categories{1}(categories{1} == j & ntrans <= cat_nthresh) = nan;
    end
end 
    
% Calculate proportions
[ stay_prop, coactive_prop, ~, coactive_bool] = ...
    get_cat_stability(categories, neuron_map, 0:5);
stay_prop = circshift(stay_prop,-1); % Shift so discarded cells are at the right
cat_names = circshift(cat_names,-1);
coactive_prop = circshift(coactive_prop,-1);

% if any(coactive_prop == 0 | coactive_prop == 1)
%     keyboard
%     disp('Debugging alt_stability_v_cat for 0/1 prob. present...')
% end
%% Step 5: Plot it
if plot_flag
    if isempty(ha)
        figure; ha = gca; set(gcf,'Position',[270 230 960 550])
    end
    
%     xlabels = {'Splitters', 'Stem PCs', 'Stem NPCs', 'Arm PCs', 'Arm NPCs', ...
%         [ 'ntrans < ' num2str(ntrans_thresh)]};
    xlabels = {'Splitters','Arm PCs', 'Arm NPCs', 'Stem PCs', 'Stem NPCs',...
        [ 'ntrans < ' num2str(ntrans_thresh)]};
    if ~coactive_only
        [ha, h1, h2] = plotyy(ha, 1:6, stay_prop, 1:6, coactive_prop);
        h1.Marker = 'o'; h2.Marker = 'o';
    else
        
    end
    
    ha(1).YLabel.String = 'Probabilty Same Category';
    ha(2).YLabel.String = 'Probability Coactive';
    
    title([mouse_name_title(MDbase.Animal) ': ' num2str(get_time_bw_sessions(...
        MDbase, MDreg)) ' day lag'])
    xlabel([mouse_name_title(MDbase.Date) 's' num2str(MDbase.Session) ' to ' ...
        mouse_name_title(MDreg.Date) 's' num2str(MDreg.Session)])
    
    for j = 1:2
        xlim(ha(j), [0.5 6.5])
        ha(j).XTick = 1:6; ha(j).XTickLabels = xlabels;
        make_plot_pretty(ha(j));
    end
elseif ~plot_flag
    ha = [];
end



end

