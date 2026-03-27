function [sig, t] = generate_sinusoid(fs, A, freq, phase, dur)
% generate_sinusoid  Generate a sinusoidal signal.
%
%   [sig, t] = generate_sinusoid(fs, A, freq, phase, dur)
%
%   fs    - sample rate (Hz)
%   A     - peak amplitude
%   freq  - frequency (Hz)
%   phase - phase offset (radians)
%   dur   - duration (seconds)

ts  = 1 / fs;
t   = 0 : ts : (dur - ts);
sig = A * cos(2*pi*freq*t + phase);
end
