function plot_spectrum(sig, fs)
% A basic function to plot the magnitude spectrum of a signal.

    N = length(sig);
    spec_length = floor(N/2 + 1);

    dft = fft(sig);
    spec = dft(1:spec_length);
    mag = abs(spec)/N;
    mag(2:ceil(N/2)) = 2*mag(2:ceil(N/2));
    mag = 20*log10(mag);

    k = 0:(spec_length - 1);
    freqs = k*fs/N;

    plot(freqs, mag);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
end