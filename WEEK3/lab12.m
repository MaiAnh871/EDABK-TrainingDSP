%View memory in workspace
A = rand (100);
B = rand (100);
%whos();
A_info = whos('A');
A_info_in_MB = A_info.bytes/1000000; %Megabytes
