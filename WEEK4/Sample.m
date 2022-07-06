% Run the MATLAB filter design and analysis tool to design
% an FIR filter and export the coefficients

fs = 48000;
buffer_size = 2^12;
tmax = 2; %full time of signal
num_frames = ceil(tmax*fs/buffer_size); 
N = num_frames*buffer_size;
x = 0.01*randn(N,1);
FIRlength = length(Num30);
x_buffer = zeros(1,FIRlength);
y_filtered = zeros(1,N);
oldest = 1;

profile off
profile on -timer 'cpu'

for n = 1:N
    x_buffer(oldest) = x(n);  % Put new input where oldest input is
    y = 0;
    for i = 1:FIRlength
        % index x_buffer starting at "oldest" where we placed new input
        idx = oldest+i-1;
        if idx > FIRlength
            idx = idx - FIRlength; % modulus operations
        end
        % compute one term of discrete-time convolution
        y = y + x_buffer(idx)*Num30(FIRlength-i+1); 
    end
    y_filtered(n) = y;
    % update of the oldest input. We no longer have shifters
    oldest = oldest + 1; 
    if oldest == (FIRlength+1)
        % If oldest index exceeds FIR filter length, perform modulo op
        oldest = 1; 
    end
end
profile viewer;

sound(y_filtered,fs);