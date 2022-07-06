%% Declare uint32 state to represent up to 32-bit state 
init = 50;
state_init = uint32 (init); % Declare uint32 state

% We can initialize state with any value between 0 and 2^32 -1 except a
% multiple of 32 cause we are using the last 5 bits so if init is a
% multiple of 32, its number in binary will be 00000, and the state "all
% zero" is a forbidden state.

%% Find the bit array representation of state with 32-bit precision
bin_state = dec2bin(state_init);

%% Extract the third bit from the right using bit operations
n_bit_pr = 1;
position_pr = 3;
bin_state_shift_2 = bitsra (state_init, position_pr - 1); % Right shift number by 2
bin_temp_1 = bitshift (1, n_bit_pr) - 1; % Create a number with 1 - set bits
bit_3_1 = bitand (bin_state_shift_2, bin_temp_1); % Do bitwise AND of 1 - set bits with modified number

%% Extract the last five bits
n_bit = 5;
position = 1;
bin_DS_state_shift = bitsra (state_init, position - 1);
bin_temp = bitshift (1, n_bit) - 1;
bit_pos_n = bitand (bin_DS_state_shift, bin_temp);

%% Verify periodic operation of SSRG [5,2]s
T = 100;
PN = zeros (1, T);
state = bit_pos_n;
for t = 1: T
    [new , state] = SSRG_update (state);
    PN(t) = new; %Save sequencely each bit into PN sequence
end
%stem(1: T, PN);

%% Make a random input sequence in {0,1}^T
input_signal = randi([0 1], 1, T); 

%% Declare DS_state, DD_state; to represent up to 32-bit state
DS_state = uint32 (init);
DD_state = uint32 (init);

% Convert into binary
bin_DS_state = dec2bin (DS_state);
bin_DD_state = dec2bin (DD_state);

% Extract the last five bits
bin_DS_state_shift = bitsra (DS_state, position - 1);
bin_DD_state_shift = bitsra (DD_state, position - 1);
DS_state5 = bitand (bin_DS_state_shift, bin_temp);
DD_state5 = bitand (bin_DD_state_shift, bin_temp);

%% Pass the scrambled bit from Data Scrambler as an input to Data Descrambler
[DS_state5, output_signal] = Data_Scrambling (DS_state5, input_signal);
[DD_state5, input_signal0] = Data_Descrambling (DD_state5, output_signal);
%subplot(3, 1, 1);
%plot (1: T, input_signal);
%title('input');
%subplot(3, 1, 2);
%plot (1: T, output_signal);
%title('output of Data Scramble');
%subplot(3, 1, 3);
%plot (1: T, input_signal0);
%title('output of Data Descramble/ input');

%%Autocorrelation Graphs
period = xcorr (PN, PN); %The distance between two consecutive vertices is the period of the series
period = 31;
% Convert into 1 & -1
for i = 1: 1: length (PN)
    if PN(i) == 0
        PN(i) = -1;
    else
        PN(i) = 1;
    end
end

% Calculate Correlation
for n = 1: 1: 62
   temp_array = [];
   for k = 1: 1: period
       temp = PN(k) * PN(n+k);
       temp_array = [temp_array temp];
   end   
   Rxx(n) = 1/period * sum (temp_array);
end

% Generate an autocorrelation graph on two periods worth of data scrambler output bit 
for i = 1: 1: length (output_signal)
    if output_signal(i) == 0
        output_signal(i) = -1;
    else
        output_signal(i) = 1;
    end
end

Rxx2 = xcorr (output_signal, output_signal);

