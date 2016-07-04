load('1219y.mat');
load('1219x.mat');

Ton = ecg_timestamps.wavedet.V1.Ton;
Toff = ecg_timestamps.wavedet.V1.Toff;
T = ecg_timestamps.wavedet.V1.T;

sample_size = size(T);
y = zeros(sample_size(1),3);


ampsize = size(ecg_amplitudes);

for i = 1:sample_size(1)
    y(i,1) = T(i)/720000; % transfer to time x-axis
    
    if isnan(T(i)) || isnan(Toff(i)) || isnan(Ton(i))|| Ton(i) > ampsize(1)       
        y(i,2) = NaN;  %tombstone ratio is NaN
        y(i,3) = NaN;  %T_amplitude is NaN
    
    else
        base1 =  ecg_amplitudes(Ton(i),7:9);
        base1 =  median(base1,'omitnan');
        
        base2 =  ecg_amplitudes(Toff(i),7:9);
        base2 =  median(base2,'omitnan');
        
        base = (base1 +base2)/2;
        
        % store
        
        y_amplitude = ecg_amplitudes(T(i),7:9);
        y(i,3)= nanmax(y_amplitude) - base; %y_amplitude
        
        
        temp = ecg_amplitudes(Ton(i):Toff(i),7:9); % consider only leads 1 to 3
        tombstone_area = sum(median(temp,2,'omitnan') - base); % sum the rows of (the median of three leads)
        total_area = y(i,3) * (Toff(i) - Ton(i));
        y(i,2) = tombstone_area/total_area; %tombstone ratio
    
    end
end


x = y(:,1);
y_amplitude= medfilt1(y(:,3),20);
plot(x,y_amplitude)
title('T\_ Amplitude: Non-ST patient 1219 Male 75\_yrs ')
xlabel('Time(hr)')
ylabel('T Amplitude');

figure
y_ratio= medfilt1(y(:,2),20);
plot(x,y_ratio)
title('T\_Ratio:Non-ST patient 1219 Male 75\_yrs')
xlabel('Time(hr)')
ylabel('T Ratio');



