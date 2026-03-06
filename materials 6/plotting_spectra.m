%% Generate Signal to Analyse
% In this example we will plot the spectra of a simple sinusoidal signal.
fs = 44100; % sampling frequency
A = 1; % amplitude
freq = 10000; % frequency
phase = 1; % phase in radians
dur = 0.1; % duration in seconds

sig = generate_sinusoid(fs, A, freq, phase, dur);

%% Find the DFT
% To plot the spectrum we firt need to find the DFT of our signal. This can
% be done using MATLAB's fft() funciton.
dft = fft(sig);

%% Plot the magnitude of the DFT
% The magnitude of the DFT is its absolute value
mag = abs(dft);

% The frequency for each coefficient, k, in the DFT is k*fs/N.
% Where fs and N are the sampling frequency and length of the signal.
N = length(sig); % the length of the signal
k = 0:(N - 1); % the k values for each coefficient
freqs = k*fs/N;

% Plot the abosolute value of the DFT coefficients. At this point we should
% see two spikes in our spectrum at 10000Hz and 34100Hz. These are the
% positive and negative frequency components of our signal. 34100Hz would 
% alias to 10000Hz when sampling at 44100Hz.
figure(1);
plot(freqs, mag);
title('Unprocessed Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%% Discarding negative frequencies
% To create a more readable spectrum plot we need to discard the negative 
% frequencies by only keeping the first floor(N/2 + 1) coefficients.
% We do this for both our coefficients and the frequency values.
spec_length = floor(N/2 + 1);
spec = dft(1:spec_length);
spec_mag = abs(spec);
spec_freqs = freqs(1:spec_length);

% Plotting only the positive frequency coefficient magnitudes. The 
% magnitude of our spectrum is looking very high. That's because it
% hasn't been normalised yet.
figure(2);
plot(spec_freqs, spec_mag);
title('Positive Half of the Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%% Normalisation and Magnitude Compensation
% To normalise the DFT coefficients we divide them by the length of the
% signal we are analysing.
normalised_mag = spec_mag/N;

% We also need to apply magnitude compensation due to the fact we discarded
% half the spectrum earlier. This is done by multiplying all the
% coefficients, other than when k = 0 or k = N/2, by 2;
normalised_mag(2:ceil(N/2)) = 2*normalised_mag(2:ceil(N/2));

% Now we can plot the normalised and compensated spectrum. Tmagnitude shown
% on our plot should now match the peak amplitude we set at the start.
figure(3);
plot(spec_freqs, normalised_mag);
title('Normalised and Corrected Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%% Plot the Phase Spectrum
% We don't need to do any normalisation or correction for the phase
% spectrum. We can just plot the complex argument of the first half of the
% DFT coefficients.
spec_phase = angle(spec);

% For DFT coefficients where there was no energy in the signal, the phase
% calcuated by MATLAB will effecivly be random. We can solve this issue by
% zeroing the phase for coefficients with magnitudes below a certain
% threshold.
spec_phase(normalised_mag < 1e-10) = 0;

% Plot the phase spectrum.
figure(4);
plot(spec_freqs, spec_phase);
title('Phase Spectrum');
xlabel('Frequency (Hz)');
ylabel('Phase (rad)');
ylim([-pi, pi]);