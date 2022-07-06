%% Symbol Generation
Nbit = 200;
xt = round(rand(1,Nbit));
xt = 2*xt-1;
 
%% Raised Cosine Filter Design
fs = 48000;         %Outphut rate
fsym = 2400;        %Input rate
sps = 20;           %Sample per symbol
span = 8;           %Filter length
alpha = 1;          
upSampleRate = 20;
coeff_rcosfilter = (1/0.2582)*rcosdesign(alpha,span,sps,'normal');
 
%% Implement
xt_upsample = upsample(xt,upSampleRate); %upsample
st = conv(xt_upsample,coeff_rcosfilter); %implement filter
t = (1:length(st)-80)/fs;
tsym = (0:length(xt)-1)/fsym;
 
%% Plot
hold off;
plot(t,st(81:length(st)));
hold on;
stem(tsym,xt);
xlabel('Time');
ylabel('Amplitude');
