%% Signal Parameters
fs = 44100; % sampling frequency
A = 1; % amplitude
freq = 220; % frequency
phase = 0; % phase in radians
dur = 1; % duration in seconds

%% Generate signal
[sig, t] = generate_sinusoid(fs, A, freq, phase, dur);

%% Plot signal
plot(t, sig);
xlabel("Time (s)");
