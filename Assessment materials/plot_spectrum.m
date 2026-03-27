function plot_spectrum(sig, fs)
% plot_spectrum  Plot the one-sided magnitude spectrum of a signal in dB.
%
%   plot_spectrum(sig, fs)
%
%   sig - row or column vector of real samples
%   fs  - sample rate (Hz)

N           = length(sig);
spec_length = floor(N/2) + 1;

dft = fft(sig(:).');          % ensure row vector
mag = abs(dft(1:spec_length)) / N;
mag(2:end-1) = 2 * mag(2:end-1);   % single-sided correction
mag_db = 20 * log10(mag + 1e-12);  % avoid log(0)

freqs = (0:spec_length-1) * fs / N;

plot(freqs, mag_db);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
end
