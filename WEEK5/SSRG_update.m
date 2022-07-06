function [new, state] = SSRG_update (state)
    state_temp = dec2bin (state, 5);
    new = mod (state_temp(1) + state_temp(5), 2);
    new_temp = num2str (new);
    for count = 5: -1: 2
       state_temp (count) = state_temp (count - 1); 
    end
    state_temp (1) = new_temp;
    state = bin2dec (state_temp);
end