%% Generate Input Signal
% For this demonstration we will process a second of white noise. White
% noise can be generated as a sequence of random numbers.
fs = 44100; % Sampling Frequency
dur = 1; % Duration in Seconds
N = fs*dur; % Length in Samples
noise = randn(1, N);

% Peak normalise the noise.
noise = noise/max(abs(noise));

%% Process the Signal in the Frequency Domain
% We will use the DFT to filter out a band of frequencies from our signal.
% First we take the DFT of the signal.
dft = fft(noise);

% Then we define the frequency range to filter out.
f1 = 2000;
f2 = 4000;

% We need to convert these to DFT coeficient indexes to work out which DFT
% coefficients we need to set to 0. Because the frequencth of the kth
% coefficients is k*fs/N, the value of k for frequency f is f*N/fs. We need
% to add one to this value because in MATLAB arrays start at an index of 1
% instead of 0.
k1 = f1*N/fs + 1;
k2 = f2*N/fs + 1;

% Now we can set the relevant coefficients in our DFT to be equal to 0.
dft(k1:k2) = 0;

% Lastly we take the IDFT of our altered coefficients to generate the
% filtered signal. Using the 'symmetric' flag here tells MATLAB to only use
% the first half of the coefficients and construct the rest using conjugate
% symmetry. If we didn't do it this way we would have also had to set the
% corresponding negative frequency coefficients to 0 ourselves.
filtered_noise = ifft(dft, 'symmetric');

%% Plot Spectra
plot_spectrum(noise, fs);
hold on;
plot_spectrum(filtered_noise, fs);
hold off;
ylim([-100, -20]);
legend('White Noise', 'Filtered Noise');