%Create continuous - time vector
fs = 1000;
Ts = 1/fs; %Ts = 0.001;
t = 0: Ts: 1 - 1/fs;
%t = t (1:100);

%Create a sinusoidal signal
f = 5;
xt = cos (2 * pi * f * t);
plot (t, xt);
title ('Sinusoidal signal');
xlabel ('time');
ylabel ('amplitude');

%Sampling continuous time sinusoidal signal
T_Sampled = 0.008;
f_Sampled = 1/ T_Sampled;
t_Sampled = 0: T_Sampled: 1 - 1/fs;
x_Sampled = cos (2 * pi * f * t_Sampled);
subplot(1,1,1);
plot (t, xt);
hold on;
stem (t_Sampled, x_Sampled);

%Discrete Fourier Transform
f_DFT = [-fs/2: fs/length(xt): fs/2 - fs/length(xt)];
fband_xt = fft (xt);
yt = fftshift (fband_xt);
fnew = log10 (abs (yt));
%plot (f_DFT, fnew);

%Discrete Time Fourier Transform
%freqz (xt);




