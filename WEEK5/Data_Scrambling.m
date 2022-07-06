function [DS_state5, output_signal] = Data_Scrambling (DS_state5, input_signal)
    DS_state_temp = dec2bin (DS_state5, 5);
    for i = 1: 1: length (input_signal)
        input_temp (i) = num2str (input_signal(i));
        mod_result = mod (DS_state_temp(2) + DS_state_temp(5), 2);
        output_signal(i) = mod (input_temp(i) + mod_result, 2);
        output_temp(i) = num2str (output_signal(i));
        for count = 5: -1: 2
            DS_state_temp (count) = DS_state_temp (count - 1); 
        end
        DS_state_temp(1) = output_temp(i);
    end
    DS_state5 = bin2dec (DS_state_temp);
end