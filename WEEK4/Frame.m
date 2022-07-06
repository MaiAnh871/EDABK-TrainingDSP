% Run the MATLAB filter design and analysis tool to design
% an FIR filter and export the coefficients

fs = 48000; 
buffer_size = 2^16; 
tmax = 2;   
num_frames = ceil(tmax*fs/buffer_size); 
N = num_frames*buffer_size; 
x_not_awgn = 0.01*randn(N,1);
x = awgn (x_not_awgn, 50);

deviceWriter = audioDeviceWriter(fs,'BufferSize',buffer_size);
profile off
profile on -timer 'cpu'
for i_frame = 1:num_frames
    first_ind = 1 +  (i_frame-1)*buffer_size;
    last_ind = i_frame*buffer_size;
    frame = x(first_ind:last_ind);
    
    %deviceWriter(frame);      %%% play the original signal  
    
    y = filter(Num30,1,frame);
    deviceWriter(y);          %%% play the filtered signal
end
profile viewer;

%% fft of x
f_frame_awgn = fftshift(fft(x));
figure
plot(-fs/2: fs/N:(fs/2 - fs/N), 10*log10(abs(f_frame_awgn)))

%%fft of y
f_frame = fftshift(fft(y));
figure
plot(-fs/2:fs/buffer_size:(fs/2-fs/buffer_size), 10*log10(abs(f_frame)))
