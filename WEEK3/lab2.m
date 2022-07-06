%%% Code to generate an array of discrete-time
%%% Cosine and sine signals one sample at a time.
%%% Arrays are pre - allocated for efficiency.
fs = 8000;                    %%% sampling freq. Hz
fDesired = 1000;              %%% desired freq. Hz
w0 = 2 * pi * fDesired/fs;    %%% discrete-time freq.
N0 = fs / gcd (fDesired, fs); %%% fundamental period
N = 50;                       %%% samples to plot
phase = 0;
y_sin = zeros(1,N);           %%% pre-allocate array
y_cos = zeros(1,N);           %%% pre-allocate array

%%% Compute N samples of the cosine and sine signals
for i=1:N
    phase = phase + w0;
  
    if (phase >= 2*pi)
        phase = phase - 2*pi;
    end

    y_sin(i) = sin(phase);
    y_cos(i) = cos(phase);
end
%%

subplot(1,2,1)
stem(1:N, y_sin)
title(['sin(2$\pi$(', num2str(fDesired),'/', num2str(fs),')n)'], 'Interpreter','latex')
xlabel( strcat(num2str(N0), ' samples in fundamental period') );
grid on

subplot(1,2,2)
stem(1:N, y_cos)
title(['cos(2$\pi$(', num2str(fDesired),'/', num2str(fs),')n)'], 'Interpreter','latex')
xlabel( strcat(num2str(N0), ' samples in fundamental period') );
grid on

%%% Compute 2s of samples of the cosine and
%%% sine signals and play them as audio signals
%%% There fs samples in one second.
tmax = 2;
M = tmax*fs;
m = 1:M;
y_cos_tmax_s = cos(w0*m);
y_sin_tmax_s = sin(w0*m);
%sound(y_cos_tmax_s, fs);
pause(tmax+1);
%sound(y_sin_tmax_s, fs);
pause(tmax+1);