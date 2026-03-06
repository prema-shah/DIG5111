function [sig, t] = generate_sinusoid(fs, A, freq, phase, dur)
% generate_sinusoid: A function to generate a sinusoidal signal 
%                    with the following parameters:
%
%                       fs: sampling frequency in Hz
%                        A: peak amplitude
%                     freq: frequency in Hz
%                    phase: phase offset in radians
%                      dur: duration in seconds

  ts = 1/fs; % calculate the sampling period
  t = 0:ts:(dur - ts); % generate sample times
  sig = A * cos(2*pi*freq*t + phase); % synthesise the signal