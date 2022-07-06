function [DD_state5, output_signal] = Data_Descrambling (DD_state5, input_signal)
    DD_state_temp = dec2bin (DD_state5, 5);
    input_temp = num2str (input_signal); % Ham num2str them dau cach vao giua cac so 
                                           % VD: num2str(10) = '1 0', cai minh can la '10' 
    input_temp = input_temp (find (~isspace(input_temp))); % Xoa dau cach
    for i = 1: 1: length (input_signal)       
        mod_result = mod (DD_state_temp(2) + input_temp(i), 2);
        output_signal(i) = mod (DD_state_temp(5) + mod_result, 2);
        for count = 5: -1: 2
            DD_state_temp (count) = DD_state_temp (count - 1); 
        end
        DD_state_temp(1) = input_temp(i);
    end
    DD_state5 = bin2dec (DD_state_temp);
end