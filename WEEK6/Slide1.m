%% Simulation of Block Diagram
%% Symbol generation
% Generate 200 random bits (0 or 1)
N = 20;                     % length of input
fs = 1000;                  % sample frequency (Hz)
f0 = 100;                   % carrier frequency (Hz)
L = fs/f0;              
t = [0: 1/fs: 1/f0 - 1/fs]; %time dimensions
r = randi([0 1], 1, N);

% Map the bits to modulation amplitudes using BPSK scheme
bit_map = [];
for i = 1: 1: N
    if r(i) == 0
        temp = -1;
    elseif r(i) == 1
        temp = 1;
    end
    bit_map = [bit_map temp];
end

% Pulse shape
shape_bit_map = kron (bit_map, ones (1, L)); %stretch one point to L points to create pulse

% Carrier wave
t = (0: 1/fs: N/f0 - 1/fs); %time dimensions
carrier_wave = sin(2* pi* f0* t);
AM_wave = shape_bit_map .* carrier_wave;

%% Raised cosine filtering
% b = rcosdesign(beta, span, sps, shape) returns
% a square-root raised cosine filter when you set shape to 'sqrt' and
% a normal raised cosine FIR filter when you set shape to 'normal'.
shape = 'normal'; 
sps = 20;                   % sample per symbol
beta = 1;                   % the excess bandwidth factor
span = 8;                   % 8 symbol periods
b = rcosdesign(beta, span, sps, shape);
%plot(b);

% y = upsample(x,n) increases the sample rate of x by inserting n – 1 zeros
% between samples. If x is a matrix, the function treats each column as a
% separate sequence.
n = 20;
input_upsampled = upsample (bit_map, n);
AM_wave_rcf = filter (b, 1, input_upsampled);
subplot (2, 1, 1);
plot(AM_wave_rcf);
subplot (2, 1, 2);
plot (bit_map);

% Filtered symbols by pulse shaping filter overlay with symbols
%subplot (2, 1, 1);
%plot (AM_wave);
%subplot (2, 1, 2);
%plot (AM_wave_rcf);


%% Eye Diagram
% eyediagram(x,n) generates an eye diagram for signal x, plotting n samples
% in each trace. The labels on the horizontal axis of the diagram range
% between –1/2 and 1/2. The function assumes that the first value of the
% signal and every nth value thereafter, occur at integer times.
%sd = eyediagram (AM_wave_rcf, sps);

%% Simulation of Block Diagram
%Plot Magnitude response
freqz(b);

%Plot impulse response
stem(b);