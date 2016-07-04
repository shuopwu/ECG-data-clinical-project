load('1219y.mat')
load('1219x.mat')
%%
lead = ecg_timestamps.wavedet.V1.QRSoff;


% get the timestamp vectors of st starts and st ends
st_strt = lead + 12; %60mv from where S start
st_end =  lead + 16; %80mv from where S end

% get loop index
sample_size = size(lead);
ampsize = size(ecg_amplitudes);

y = zeros(sample_size);
x = zeros(sample_size);

% loop through st amplitudes
for i = 1:sample_size(1)
    x(i) = st_strt(i)/720000;
    % get the st-elevation median
    if isnan(st_strt(i)) || isnan(st_end(i)) || st_end(i) > ampsize(1)
        
        y(i) = NaN;   
    
    else      
        % store
        temp = ecg_amplitudes(st_strt(i):st_end(i),:);
        temp2 = median(temp,'omitnan');
        yi = median(temp2);  
        y(i) = yi;
    end
end

x1 = x(~isnan(y));
y1 = y(~isnan(y));
y1 = medfilt1(y1,20);
%%
lead = ecg_timestamps.wavedet.V2.QRSoff;


% get the timestamp vectors of st starts and st ends
st_strt = lead + 12; %60mv from where S start
st_end =  lead + 16; %80mv from where S end

% get loop index
sample_size = size(lead);
ampsize = size(ecg_amplitudes);

y = zeros(sample_size);
x = zeros(sample_size);

% loop through st amplitudes
for i = 1:sample_size(1)
    x(i) = st_strt(i)/720000;
    % get the st-elevation median
    if isnan(st_strt(i)) || isnan(st_end(i)) || st_end(i) > ampsize(1)
        
        y(i) = NaN;   
    
    else      
        % store
        temp = ecg_amplitudes(st_strt(i):st_end(i),:);
        temp2 = median(temp,'omitnan');
        yi = median(temp2);  
        y(i) = yi;
    end
end

x2 = x(~isnan(y));
y2 = y(~isnan(y));
y2 = medfilt1(y2,20);
%%
lead = ecg_timestamps.wavedet.V3.QRSoff;

% get the timestamp vectors of st starts and st ends
st_strt = lead + 12; %60mv from where S start
st_end =  lead + 16; %80mv from where S end

% get loop index
sample_size = size(lead);
ampsize = size(ecg_amplitudes);

y = zeros(sample_size);
x = zeros(sample_size);

% loop through st amplitudes
for i = 1:sample_size(1)
    x(i) = st_strt(i)/720000;
    % get the st-elevation median
    if isnan(st_strt(i)) || isnan(st_end(i)) || st_end(i) > ampsize(1)
        
        y(i) = NaN;   
    
    else      
        % store
        temp = ecg_amplitudes(st_strt(i):st_end(i),:);
        temp2 = median(temp,'omitnan');
        yi = median(temp2);  
        y(i) = yi;
    end
end

x3 = x(~isnan(y));
y3 = y(~isnan(y));
y3 = medfilt1(y3,20);
%%
lead = ecg_timestamps.wavedet.V4.QRSoff;


% get the timestamp vectors of st starts and st ends
st_strt = lead + 12; %60mv from where S start
st_end =  lead + 16; %80mv from where S end

% get loop index
sample_size = size(lead);
ampsize = size(ecg_amplitudes);

y = zeros(sample_size);
x = zeros(sample_size);

% loop through st amplitudes
for i = 1:sample_size(1)
    x(i) = st_strt(i)/720000;
    % get the st-elevation median
    if isnan(st_strt(i)) || isnan(st_end(i)) || st_end(i) > ampsize(1)
        
        y(i) = NaN;   
    
    else      
        % store
        temp = ecg_amplitudes(st_strt(i):st_end(i),:);
        temp2 = median(temp,'omitnan');
        yi = median(temp2);  
        y(i) = yi;
    end
end

x4 = x(~isnan(y));
y4 = y(~isnan(y));
y4 = medfilt1(y4,20);
%%
lead = ecg_timestamps.wavedet.V5.QRSoff;


% get the timestamp vectors of st starts and st ends
st_strt = lead + 12; %60mv from where S start
st_end =  lead + 16; %80mv from where S end

% get loop index
sample_size = size(lead);
ampsize = size(ecg_amplitudes);

y = zeros(sample_size);
x = zeros(sample_size);

% loop through st amplitudes
for i = 1:sample_size(1)
    x(i) = st_strt(i)/720000;
    % get the st-elevation median
    if isnan(st_strt(i)) || isnan(st_end(i)) || st_end(i) > ampsize(1)
        
        y(i) = NaN;   
    
    else      
        % store
        temp = ecg_amplitudes(st_strt(i):st_end(i),:);
        temp2 = median(temp,'omitnan');
        yi = median(temp2);  
        y(i) = yi;
    end
end

x5 = x(~isnan(y));
y5 = y(~isnan(y));
y5 = medfilt1(y5,20);
%%
lead = ecg_timestamps.wavedet.V6.QRSoff;


% get the timestamp vectors of st starts and st ends
st_strt = lead + 12; %60mv from where S start
st_end =  lead + 16; %80mv from where S end

% get loop index
sample_size = size(lead);
ampsize = size(ecg_amplitudes);

y = zeros(sample_size);
x = zeros(sample_size);

% loop through st amplitudes
for i = 1:sample_size(1)
    x(i) = st_strt(i)/720000;
    % get the st-elevation median
    if isnan(st_strt(i)) || isnan(st_end(i)) || st_end(i) > ampsize(1)
        
        y(i) = NaN;   
    
    else      
        % store
        temp = ecg_amplitudes(st_strt(i):st_end(i),:);
        temp2 = median(temp,'omitnan');
        yi = median(temp2);  
        y(i) = yi;
    end
end

x6 = x(~isnan(y));
y6 = y(~isnan(y));
y6 = medfilt1(y6,20);

%%
figure
plot(x1,y1,x2,y2+10,x3,y3+20,x4,y4+30,x5,y5+40,x6,y6+50)
title('Non\_ST patient S1219 Male 75\_yr\_old')
xlabel('Time(hr)')
ylabel('Y Amplitude(mv)')
legend('V1','V2','V3','V4','V5','V6')

% figure
% polar(x./2,y)
% view([90 -90])
% savefig('yround_lead1.fig')

%%








