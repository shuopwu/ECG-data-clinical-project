%load data
load('1288_y.mat')
load('1288_x.mat')

lead = ecg_timestamps.wavedet.V1.QRSoff;

st_strt = lead + 12; %60mv from where S start
st_end =  lead + 16; %80mv from where S end

sample_size = size(lead);
ampsize = size(ecg_amplitudes);

y = zeros(sample_size);
x = zeros(sample_size);

for i = 1:sample_size(1)-2
    x(i) = st_strt(i)/720000;
    if isnan(st_strt(i)) || isnan(st_end(i)) || st_end(i) > ampsize(1)
        y(i) = NaN;  
    
    else
        beati = ecg_amplitudes(st_strt(i):st_end(i),:);
        
        yi_strt = beati(1:4,:);
        yi_end = beati(2:5,:);
        yi_diff = yi_end - yi_strt;
        
        y_diff = median(median(yi_diff,'omitnan'));

        y(i) = y_diff;
        
    end
            
end

x1 = x(~isnan(y));
y1 = y(~isnan(y));
y1 = medfilt1(y1,20);


lead = ecg_timestamps.wavedet.V2.QRSoff;

st_strt = lead + 12; %60mv from where S start
st_end =  lead + 16; %80mv from where S end

sample_size = size(lead);
ampsize = size(ecg_amplitudes);

y = zeros(sample_size);
x = zeros(sample_size);

for i = 1:sample_size(1)-2
    x(i) = st_strt(i)/720000;
    if isnan(st_strt(i)) || isnan(st_end(i)) || st_end(i) > ampsize(1)
        y(i) = NaN;  
    
    else
        beati = ecg_amplitudes(st_strt(i):st_end(i),:);
        
        yi_strt = beati(1:4,:);
        yi_end = beati(2:5,:);
        yi_diff = yi_end - yi_strt;
        
        y_diff = median(median(yi_diff,'omitnan'));

        y(i) = y_diff;
        
    end
            
end

x2 = x(~isnan(y));
y2 = y(~isnan(y));
y2 = medfilt1(y2,20);

lead = ecg_timestamps.wavedet.V3.QRSoff;

st_strt = lead + 12; %60mv from where S start
st_end =  lead + 16; %80mv from where S end

sample_size = size(lead);
ampsize = size(ecg_amplitudes);

y = zeros(sample_size);
x = zeros(sample_size);

for i = 1:sample_size(1)-2
    x(i) = st_strt(i)/720000;
    if isnan(st_strt(i)) || isnan(st_end(i)) || st_end(i) > ampsize(1)
        y(i) = NaN;  
    
    else
        beati = ecg_amplitudes(st_strt(i):st_end(i),:);
        
        yi_strt = beati(1:4,:);
        yi_end = beati(2:5,:);
        yi_diff = yi_end - yi_strt;
        
        y_diff = median(median(yi_diff,'omitnan'));

        y(i) = y_diff;
        
    end
            
end

x3 = x(~isnan(y));
y3 = y(~isnan(y));
y3 = medfilt1(y3,20);


figure
plot(x1,y1,x2,y2,x3,y3)
title(' ST patient S1288 Male 57\_yrs')
xlabel('Time(hr)')
ylabel('ST_amplitudes_slope')



