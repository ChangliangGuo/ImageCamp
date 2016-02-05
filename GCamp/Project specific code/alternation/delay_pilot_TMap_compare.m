function [] = delay_pilot_TMap_compare(continuous_sesh, delay_sesh, filter_use, plot_type,varargin)
% delay_pilot_TMap_compare(continuous_sesh, delay_sesh, filter_use)
% Plot TMaps for continuous v delay and compare to continuous within
% session
%
% continuous_sesh and delay_sesh are sessions from MakeMouseSessionList
% that you wish to use.  They must come from the same recording session and
% have the same number of neurons, but should be of different block types
% (e.g. continous vs. delay). 
%
% filter_use is a vector of neuron numbers that you wish to include
%
% plot_type: 1 = scroll through each neuron for visual inspection
%            2 = run through and save each plot to the continuous_sesh
%            directory
%
% varargins: 'disp_iffr': display in-field firing rate - must be followed
% by output PFhits and PFiffr from function IFFR_Sam, e.g.
% ...'disp_iffr',PFhits,PFiffr,...

%% Set plot_type if not specified
if nargin < 4
    plot_type = 1;
end
%% Get varargins
PFhits = []; % default
PFiffr = []; % default
PFpasses = []; % default
disp_iffr = 0; % default
for j = 1:length(varargin)
   if strcmpi('disp_iffr',varargin{j})
       disp_iffr = 1; % plot flag
       % Get and calculate all required values for plotting
       PFhits = varargin{j+1};
       PFiffr = varargin{j+2};
       PFpasses = round(PFhits*100./PFiffr);
   end
end

session_use = continuous_sesh; % Continuous block(s)
session_use(2) = delay_sesh; % Delay block(s)

% Load relevant variables from each session
ChangeDirectory_NK(session_use(1));
load('PlaceMaps.mat', 'RunOccMap', 'TMap_gauss', 'pval','x','y','t','FT');
load('PFstats','PFpcthits');
TMap_continuous = TMap_gauss;
RunOccMap_continuous = RunOccMap;
pcthits_continuous = PFpcthits;
pval_continuous = pval;

ChangeDirectory_NK(session_use(2));
load('PlaceMaps.mat', 'RunOccMap', 'TMap_gauss', 'pval');
load('PFstats','PFpcthits');
TMap_delay = TMap_gauss;
RunOccMap_delay = RunOccMap;
pcthits_delay = PFpcthits;
pval_delay = pval;

% % filter neurons - keep ones that have ok pval in either session
% neuron_use_either = find(pval_continuous > (1 - pval_thresh) | ...
%     pval_delay > (1-pval_thresh));

%% scroll through and plot everything

neurons_to_plot = filter_use; 

h1 = figure(501); 
cm = colormap('jet');
for j = 1:length(neurons_to_plot) 
    clf
    % Scale each TMap to reflect pcthits
    TMap_cont_scale = scale_TMap_rough(TMap_continuous{neurons_to_plot(j)},...
        max(pcthits_continuous(neurons_to_plot(j),:)));
    TMap_delay_scale = scale_TMap_rough(TMap_delay{neurons_to_plot(j)},...
        max(pcthits_delay(neurons_to_plot(j),:)));
    
    cmax = max([TMap_cont_scale(:); TMap_delay_scale(:)]);
    cmin = min([TMap_cont_scale(:); TMap_delay_scale(:)]);
    
    % Make non-occupied spots white
    [~, TMap_cont_nan] = make_nan_TMap(RunOccMap_continuous,...
        TMap_cont_scale); % Continuous blocks
    [~, TMap_delay_nan] = make_nan_TMap(RunOccMap_delay,...
        TMap_delay_scale); % Delayed blocks
    
    corr_plot(j) = corr(TMap_continuous{neurons_to_plot(j)}(:),...
        TMap_delay{neurons_to_plot(j)}(:)); % Get correlation value
    
%     % Make non-occupied spots white - continuous by block 
%     for k = 1:2
%         [~, TMap_cont_half_nan{k}] = make_nan_TMap(RunOccMap,...
%             TMap_cont_half(k).TMap_gauss{neurons_to_plot(j)}); 
%     end
    
    subplot(6,1,[1 2]); 
    imagesc_nan(rot90(TMap_cont_nan,1), cm, [1 1 1], [cmin, cmax]);
    colorbar('Ticks', [cmin, cmax]); % Add colorbar
    title(['Continuous - neuron ' num2str(neurons_to_plot(j)) ...
        ' with correlation = ' num2str(corr_plot(j))])
    
    subplot(6,1,[3 4]); 
    imagesc_nan(rot90(TMap_delay_nan,1), cm, [1 1 1], [cmin, cmax]);
    colorbar('Ticks', [cmin, cmax]); % Add colorbar
    title(['Delayed - neuron ' num2str(neurons_to_plot(j))])
    
    trans_train = logical(FT(neurons_to_plot(j),:));
    
    subplot(6,1,[5 6])
    plot(t,x,'b',t(trans_train),x(trans_train),'r*');
    xlabel('time (s)'); ylabel('x position (cm)');
    legend('Trajectory','Ca Transients');
    
    if disp_iffr == 1
        %%% ADD TEXT FOR IFFR %%% - note that these are only work well for
        %%% Nat's computer setup currently - may need to tweak for your own...
        % Create textbox
        
        % If there are multiple place-fields, identify which one has the
        % maximum IFFR in EITHER condition
        
        [~, ~, max_field_num] = find(max(PFiffr(neurons_to_plot(j),:)) ...
            == PFiffr(neurons_to_plot(j),:,:));
        
        if any(PFiffr(neurons_to_plot(j),:))
            
            try
                annotation(figure(h1),'textbox',...
                    [0.01271875 0.802618328298087 0.09275 0.0453172205438066],...
                    'String',{['IFFR = ' num2str(PFiffr(neurons_to_plot(j),max_field_num,1))],...
                    ['( ' num2str(PFhits(neurons_to_plot(j),max_field_num,1)) ' hits / '], ...
                    [ num2str(PFpasses(neurons_to_plot(j),max_field_num,1)) ' passes)']},...
                    'FitBoxToText','on');
                
                % Create textbox
                annotation(figure(h1),'textbox',...
                    [0.01428125 0.505538771399799 0.08728125 0.0493454179254783],...
                    'String',{['IFFR = ' num2str(PFiffr(neurons_to_plot(j),max_field_num,2))],...
                    ['( ' num2str(PFhits(neurons_to_plot(j),max_field_num,2)) ' hits / '], ...
                    [ num2str(PFpasses(neurons_to_plot(j),max_field_num,2)) ' passes)']},...
                    'FitBoxToText','on');
            catch
                disp('Annotation error-catching enabled')
                keyboard
            end
        else
            disp(['Error in ' num2str(neurons_to_plot(j)) ' PFiffr'])
        end
    
    end
    
%     subplot(6,1,6)
%     plot(t,y,'b',t(trans_train),y(trans_train),'r*');
%     xlabel('time (s)'); ylabel('y position (cm)');
%     legend('Trajectory','Ca Transients');
%     
%     half_name = {'1st','2nd'};
%     for k = 1:2
%         subplot(2,2,2+k)
%         imagesc_nan(TMap_cont_half_nan{k},dm,[1 1 1]);
%         title(['Continuous ' half_name{k} ' - neuron ' num2str(neurons_to_plot(j))])
%     end
%     
    if plot_type == 1
        waitforbuttonpress;
    else
        disp('Haven''t finished code for plot_type = 2 yet!')
        break
    end
end

end