subplot(1,1,1);
%%Initiate and Sample
% 1 giay thu duoc fs mau, 1 mau keo dai trong 1/fs giay, data mau keo dai
% trong data/fs giay
%Original signal
[data, f] = audioread('C:\Users\Admin\Documents\data.m4a');
data = data(70000: 70080);
f = 48000;
T = 1/f;
t = 0: T: length(data)/f - T;

%Sampled signal
dataSampled = downsample (data, 6);  %xSample
fs = 8000;
Ts = 1/fs; %Ts = 0.000125
tSampled = 0: Ts: length(dataSampled)/fs - Ts; %0: 0.000125: 2.3605

%Draw
%subplot(4,1,1);
plot(t, data);
hold on;
stem(tSampled, dataSampled);
title('original signal');

%%Draw Spectrum
f = [-fs/2: fs/length(dataSampled): fs/2 - fs/length(dataSampled)];
speData = speDr(dataSampled);
plot (f, speData); %a axis expresses the frequency of the signal

%%Reconstruction
tResampled = 0: Ts/4: length(dataSampled)/fs - Ts; %Need more sample so decrease the Ts

%% Using linear interpolation
dataLinear = interp1(tSampled, dataSampled, tResampled, 'linear');
%subplot(4,1,2)
%plot(t, data, '-', ...
    %tSampled, dataSampled, 'o-', ...
    %tResampled, dataLinear, '.-');
title('linear interpolution');

% Using cubic spline interpolution
dataSpline = interp1(tSampled, dataSampled, tResampled, 'spline');
%subplot(4,1,3)
%plot(t, data, '-', ...
     %tSampled, dataSampled, 'o-', ...
     %tResampled, dataSpline, '.-');
%title('cubic spline interpolution');

% Using ideal bandlimited interpolution
dataIdeal_bl = zeros(1, length(tResampled));
for i = 1: 1: length(tResampled)
    for n = 0: length(tSampled) - 1
        dataIdeal_bl(i) = dataIdeal_bl(i) + dataSampled(n+1) * sinc((tResampled(i) - n * Ts) / Ts);
    end
end
%subplot(4,1,4)
%plot(t, data, '-', ...
     %tSampled, dataSampled, 'o-', ...
     %tResampled, dataIdeal_bl, '.-')
%title('ideal bandlimited interpolution')
