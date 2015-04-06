function [] = PostProcessICA6(NumICA,MinThreshPixels)
% this function takes an ICA .mat file as written by Inscopix Mosaic,
% does a bit of post-processing, and hopefully spits out something
% that will form the basis for my continued employment as a scientist

% this version does the background correction in a very different
% way than the initial version.

close all;


% "Magic numbers"

MicronsPerPix = 1.16; % not correct

ICSignalThresh = 15; %[was 25] Dividing line between inside and outside of cell ROI
SR = 20; % Sampling rate in Hz
MaxSignalRad = 14; % maximum radius from middle of ICA for main component

OutNoiseRad = 16; % Outer circle radius of noise ring, big enough to form a complete circle around the signal
InNoiseRad = 5; % Inner circle radius of noise ring, we want some overlap with the signal


if (nargin == 0 || nargin == 1)
    MinThreshPixels = 60;
end


% Load the independent components

for i = 1:NumICA % load the ICA .mat file, put it in a data structure
    filename = ['Obj_',int2str(i),'_1 - IC filter ',int2str(i),'.mat'];
    load(filename); % loads two things, Index and Object
    IC{i} = Object(1).Data;
end

Xdim = size(IC{1},1)
Ydim = size(IC{1},2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display('Calculating signal masks'); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create new IC filters with values less than ICSignalThresh zeroed
% This isolates the pixels that are part of the neuron

for i = 1:NumICA
    % just zero out everything less than ICSignalThresh 
    temp = IC{i};
    temp(temp < ICSignalThresh) = 0;
     
    ThreshIC{i} = temp;
    ThreshICnz{i} = find(ThreshIC{i} > 0);
    COM{i} = centerOfMass(temp);
end

% Zero out IC pixels too far away from the center
% This step is mostly to take care of edge cases where the ThreshIC
% has non-contiguous values

for i = 1:NumICA
    center = COM{i};
    for j = 1:length(ThreshICnz{i})
        [ind(1),ind(2)] = ind2sub(size(ThreshIC{i}),ThreshICnz{i}(j));
        d = norm(ind-center);
        if (d > MaxSignalRad) 
            ThreshIC{i}(ThreshICnz{i}(j)) = 0;
        end
    end
    ThreshICnz{i} = find(ThreshIC{i} > 0);
    COM{i} = centerOfMass(ThreshIC{i});
end


% Deal with overlapping pixels between ICs by zeroing them out
for i = 1:NumICA
    for j = 1:NumICA
        if (i == j) continue;end; % don't zero the whole thing out!
        
        % Check for overlap between inside and inside
        common = intersect(ThreshICnz{i}(:),ThreshICnz{j}(:));
        if (length(common) > 0) % we got some overlap, zero out both
            ThreshIC{i}(common) = 0;
            ThreshIC{j}(common) = 0;
            ThreshICnz{i} = find(ThreshIC{i} > 0);
            ThreshICnz{j} = find(ThreshIC{j} > 0);
        end
    end
end

% Just set the masks to all ones; no weighting of pixels (easier to
% justify)

for i = 1:NumICA
    ThreshIC{i}(ThreshICnz{i}) = 1;
end

% Look at size distribution of IC's
for i = 1:NumICA
    ICsize(i) = length(ThreshICnz{i});
end

% Plot the IC size distribution
FigNum = 1;
figure(FigNum);hist(ICsize,20);xlabel('# of non-zero pixels');ylabel('# of ICs');
FigNum = FigNum + 1;



% Add up the IC filters
All_Mask = zeros(size(IC{1}));

for i = 1:NumICA
   All_Mask = All_Mask+ThreshIC{i};
end
figure(FigNum);imagesc((1:Xdim)*MicronsPerPix,(1:Ydim)*MicronsPerPix,All_Mask);
FigNum = FigNum + 1;
caxis([0 1]);xlabel('microns');ylabel('microns');title('IC signal masks');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display('Calculating noise masks'); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%NonSignalMask is pixels that are eligible to be part of the noise mask,
%including the signal mask

for i = 1:NumICA
  NonSignalMask_idx{i} = find((All_Mask-ThreshIC{i}) == 0);
end

for i = 1:NumICA
  c = COM{i};
  if (isempty(c)) % zero out variables for ICs with no pixels
      RingMask{i} = zeros(size(IC{1}));
      RingMasknz{i} = [];
      NoiseMask_idx{i} = [];
      continue;
  end
  
  % Identify a ring of pixels around the center
  for k = 1:Xdim
      for l = 1:Ydim
         pixdist = norm([k l]-c);
         RingMask{i}(k,l) = (pixdist < OutNoiseRad) && (pixdist > InNoiseRad);
      end
  end  
  RingMasknz{i} = find(RingMask{i}(:) > 0);
  
  % NoiseMask is the intersection of the ring mask and nonsignal mask
  NoiseMask_idx{i} = intersect(RingMasknz{i},NonSignalMask_idx{i});
  NoiseMask{i} = zeros(size(IC{1}));
  NoiseMask{i}(NoiseMask_idx{i}) = 1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display('Loading movie data'); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MovieData dims are X,Y,T
info = h5info('FLmovie.h5','/Object');
NumFrames = info.Dataspace.Size(3);

t = (1:NumFrames)/SR;

smwin = hann(SR/2)./sum(hann(SR/2)); % 500ms smoothing window

% initialize trace matrices
SignalTrace = zeros(NumICA,NumFrames);
NoiseTrace = zeros(NumICA,NumFrames);

parfor j = 1:NumFrames
  display(['Calculating F traces for movie frame ',int2str(j),' out of ',int2str(NumFrames)]);
  tempFrame = h5read('FLmovie.h5','/Object',[1 1 j 1],[Xdim Ydim 1 1]);
  
    for i = 1:NumICA
      % Calculate mean signal value 
      SignalTrace(i,j) = sum(sum(tempFrame(ThreshICnz{i})))./length(ThreshICnz{i});
      
      % Calculate mean noise
      tempNoise = tempFrame(NoiseMask_idx{i});
      NoiseTrace(i,j) = mean(tempNoise(:));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display('calculating compensated signal');%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CSignalTrace = zeros(NumICA,NumFrames);
for i = 1:NumICA
    %smooth the signal and noise and then subtract
    CSignalTrace(i,:) = convtrim(SignalTrace(i,:),smwin)-convtrim(NoiseTrace(i,:),smwin);
    
    % find the correct zero value, subtract it, 
    [counts,centers] = hist(CSignalTrace(i,:),400);
    [val,idx] = max(counts);
    CSignalTrace(i,:) = CSignalTrace(i,:)-centers(idx);
    CSignalTrace(i,:) = CSignalTrace(i,:)./std(CSignalTrace(i,:));
end

% Step 6: Manually step through
figure(FigNum);FigNum = FigNum + 1;
for i = 1:NumICA
    if (isnan(CSignalTrace(i,1)) || (ICsize(i) < MinThreshPixels))
        GoodIC(i) = 0;
        continue;
    end
    
    subplot(3,3,1);imagesc(ThreshIC{i}-NoiseMask{i});axis square;caxis([-1 1]);
    [counts,bins] = hist(CSignalTrace(i,:),200);
    
    cs = cumsum(counts);
    d2cs = diff(cs,2);
    [val,idx] = min(d2cs);
    newzero = bins(idx+2);
    figure(FigNum-1); % NRK Edit
    subplot(3,3,2);hist(CSignalTrace(i,:),200);line([newzero newzero],[0 max(counts)],'Color','r');axis tight;
    subplot(3,3,3);plot(bins,zscore(cumsum(counts)));hold on;plot(bins(2:end),zscore(diff(cs,1)),'-r');plot(bins(3:end),zscore(diff(cs,2)),'-g');hold off;axis tight;
    subplot(3,3,4:6);plot(t,CSignalTrace(i,:));axis tight;hold on;line([t(1) t(end)],[newzero newzero],'Color','r');hold off;
    subplot(3,3,7:9);plot(t,SignalTrace(i,:));hold on;plot(t,NoiseTrace(i,:),'-r');axis tight;hold off;
    display(['Signal pixels: ',int2str(length(ThreshICnz{i})),'  Noise pixels: ',int2str(length(NoiseMask_idx{i}))]);
    ToKeep = input([int2str(i),' Keep this one or not? [y,n] --->'],'s');
    if (strcmp(ToKeep,'y') ~= 1)
        GoodIC(i) = 0;
    else
        GoodIC(i) = 1;
    end
    CSignalTrace(i,:) = CSignalTrace(i,:)-newzero;
end

GoodICidx = find(GoodIC == 1);
NumGood = length(GoodICidx);

GoodSignalTrace = CSignalTrace(GoodICidx,:);
GoodCom = COM(GoodICidx);
GoodICf = ThreshIC(GoodICidx);

d = date; % today's date
scriptname = mfilename('fullpath');
filestruct = dir([scriptname,'.m']);

AllIC = zeros(size(GoodICf{1}));

for i = 1:length(GoodICidx)
    AllIC = AllIC + GoodICf{i};
end

save SignalTrace.mat GoodSignalTrace GoodCom GoodICf ThreshIC GoodIC AllIC NoiseMask COM d scriptname filestruct;



figure(FigNum);
FigNum = FigNum + 1;
imagesc((1:Xdim)*MicronsPerPix,(1:Ydim)*MicronsPerPix,AllIC);
xlabel('microns');ylabel('microns');title('final neuronal masks');


% 
% for i = 1:NumGood
%     for j = 1:NumGood
%         p1 = GoodCom{i};
%         p2 = GoodCom{j};
%         ICdistance(i,j) = norm(p1-p2);
%     end
% end
% 
% 
% %GoodSignalTrace(find(GoodSignalTrace < 4)) = 0;
% 
% [r,p] = corr(GoodSignalTrace');
% 
% figure(3);
% imagesc(r);
% 
% figure(4);
% plot(r(:),ICdistance(:),'*')





keyboard;


% NRK Questions for Dave:
% 1) What do you do when you have two separate masks that, if combined,
% look like one neuron?  Are they just two cells at different depths?
% 2) Is there any way to ID which cell is which IC after the fact?  That
% would be sweet...


    


