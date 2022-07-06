%Spectrum drawing function
function [spectrum] = speDr (signal)
    fband = fft(signal);
    Aband = abs(fband);
    spectrum = fftshift(Aband);
end
