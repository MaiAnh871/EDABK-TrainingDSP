%Stopwatch Timer
timerVal = tic;
A = rand (100);
B = rand (100);
C = A * B;
elapsedTime = toc (timerVal);

%Profiler
profile on - timer 'cpu';
C = A * B;
profile off;
profile viewer;


