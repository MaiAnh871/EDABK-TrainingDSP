fs = 48000;         % Output rate
fsym = 2400;        % Input rate
N = 2000;
r = randi([0 1], 1, N);

bit_map = [];
for i = 1: 1: N
    if r(i) == 0
        temp = -1;
    elseif r(i) == 1
        temp = 1;
    end
    bit_map = [bit_map temp];
end

shape = 'normal'; 
sps = 20;                   % sample per symbol
beta = 1;                   % the excess bandwidth factor
span = 8;                   % 8 symbol periods
h = rcosdesign(beta, span, sps, shape);

n = 20;
input_upsampled = upsample (bit_map, n);
transmit_wave = conv (h, input_upsampled);
plot(transmit_wave);

transmit_sampled = transmit_wave (81: 20: 40001);
