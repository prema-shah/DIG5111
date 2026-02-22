%% Read audio file
% MATLAB's audioread() function can be used to read audio data from a file.
% The first two values returned by audioread() are an array of audio sample
% values and the sampling frequency of the audio.
[sig, fs] = audioread("quack.wav");

%% Get size information
% Audio data is imported as a 2D array with one column for each channel. We
% can determine the number of channels by counting the number of colums
% and the signal length in samples by counting the number of rows.
dims = size(sig);
n_samples = dims(1);
n_channels = dims(2);

%% Calculate duration
% The duration in seconds is just the number of samples divided by the
% sampling frequency.
dur = n_samples/fs;

%% Plot time domain
% To plot the waveform of our file we need to produce an array of time
% values for each sample. First we need the sampling period.
ts = 1/fs;

% Successive samples are one sampling period apart in time. Timestamps for
% Each sample can be found by enumerating each sample and multiplying
% by the sampling period.
t = (0:(n_samples - 1)) * ts;

% The plot() function allows us to plot our signal against these
% timestamps.
figure(1);
plot(t, sig);
ylim([-1, 1]);
time_label = "Time (s)";
xlabel(time_label);

%% Plot left and right channels separately
% This file is a stereo file so we might want to plot the left and right
% channels separatly. To do this we need to split them apart.
figure(2);

% Loop over each channel in our audio data.
for i = 1:n_channels
    % Get the ith column (channel) of audio data.
    % : as an index specifies that we want the entrity of the specified
    % dimension. Here we want all values (samples) in the ith column.
    chan = sig(:, i);

    % Plot the channel data as a subplot.
    subplot(n_channels, 1, i);
    plot(t, chan);
    ylim([-1, 1]);
    ylabel(sprintf("Channel %d", i));
    xlabel(time_label);
end

%% Cut out a single quack
% To cut out a segment of audio we need to select a certain range of
% samples from the array.

% We start by specifying the start and end times of the cut in seconds.
start_time = 0.8;
end_time = 1.3;

% The convert them to sample numbers.
start_sample = round(start_time * fs);
end_sample = round(end_time * fs);

% We can then use these sample numbers to select a portion of the audio.
% a:b produces an array of all the integers between, and including, a and
% b. So here we are asking for all samples of audio between start_sample
% and end_sample. The : as the second index indicats we want all channels.
one_quack = sig(start_sample:end_sample, :);

% Produce a new array of timestamps for this new segment of audio.
t2 = 0:ts:(end_time - start_time);

% Plot the audio segment.
figure(3);
plot(t2, one_quack);
xlabel(time_label);