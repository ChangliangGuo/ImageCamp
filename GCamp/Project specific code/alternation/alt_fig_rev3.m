% Alternation Reviewer 3 response figures
[MD, ~, ref] = MakeMouseSessionListEraser('natlaptop');
%% Get transient 1/2 lengths for beginning and end session
sessions = MD([32, 42]); % Eraser session for reference ! session at beginning and end of recording
% sessions = MD([238, 258]); % G30 session at beginning and end of recording
% sessions = MD([226, 235]); % G31 beginning/end session 
% sessions = MD([335, 363]); % G45 beginning/end session 
sessions = MD([401, 452]); % G48 beginning/end session
for m = 1:2
    session = sessions(m);
    dir_use = ChangeDirectory_NK(session);
    load(fullfile(dir_use,'FinalOutput.mat'), 'PSAbool', 'NeuronTraces',...
        'SampleRate');
    
    nneurons = size(PSAbool,1);
    
    % Generate plots for random # neurons
    nplot = 10; % must be even
    neuron_ind = randperm(nneurons, nplot);
    figure('Position', [40, 70, 1380, 700]);
    for j = 1:nplot
        k = neuron_ind(j);
        plot_aligned_trace(PSAbool(k,:), NeuronTraces.RawTrace(k,:), ...
            NeuronTraces.LPtrace(k,:),'SR', SampleRate, 'ax', subplot(2,nplot/2,j));
    end
    
    % Now calculate stats for all neurons
    half_all_mean = nan(nneurons,1);
    half_mean = nan(nneurons,1);
    for j = 1:nneurons
        [half_all, half_mean(j), LPerror, bad_trans_error, poor_merge] = ...
            plot_aligned_trace(PSAbool(j,:), NeuronTraces.RawTrace(j,:), ...
            NeuronTraces.LPtrace(j,:),'SR', SampleRate, 'plot_flag', false);
        if any(LPerror)
            disp(['Low-pass artifact discovered in neuron ' num2str(j) ...
                ': transient #s: ' num2str(find(LPerror))])
        end
        if all(~legit_trans)
            disp(['All transients are sketchy in neuron ' num2str(j)])
        elseif any(~legit_trans)
            disp(['Sketchy traces in neuron ' num2str(j) ': transient #s: ' ...
                num2str(find(~legit_trans))])
        end
        if poor_merge
            disp(['Poor merge discovered in neuron ' num2str(j)])
        end
        
        half_all_mean(j) = nanmean(half_all);
    end


    % Now plot all in a histogram
    if m == 1
        hcomb = figure; set(gcf,'Position', [50, 50, 950, 600])
    else
        figure(hcomb);
    end
    
    subplot(2,2,1+(m-1)*2)
    histogram(half_mean); hold on;
    plot([1 1]*nanmean(half_mean), get(gca,'YLim'),'k-')
    xlabel('\tau_{1/2,mean} (sec)')
    title([mouse_name_title(session.Animal) ': ' mouse_name_title(session.Date) ...
        ' -s' num2str(session.Session)])
    
    subplot(2,2,2+(m-1)*2)
    histogram(half_all_mean); hold on;
    plot([1 1]*nanmean(half_all_mean), get(gca,'YLim'),'k-')
    xlabel('tau_{1/2,all,mean} (sec)')
end
toc

%% Next step - toss out all neurons with values over threshold - 
% look at good PFs and good splitters - do they have high half-lives?

%% Get min fluorescence

