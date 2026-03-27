function [b, a] = peaking_biquad(f0, Q, gain_dB, fs)
% peaking_biquad  Coefficients for a peaking (bell) biquad EQ section.
%
%   [b, a] = peaking_biquad(f0, Q, gain_dB, fs)
%
%   f0       - centre frequency (Hz)
%   Q        - quality factor (controls bandwidth; higher = narrower peak)
%   gain_dB  - boost (+) or cut (-) in dB
%   fs       - sample rate (Hz)
%
%   Returns second-order filter coefficients b = [b0, b1, b2] and
%   a = [1, a1, a2] (a(1) is normalised to 1).
%
%   Formula from the Audio EQ Cookbook (Zolzer).

A     = 10^(gain_dB / 40);           % linear amplitude factor
w0    = 2*pi*f0 / fs;
alpha = sin(w0) / (2*Q);

b0 =  1 + alpha * A;
b1 = -2 * cos(w0);
b2 =  1 - alpha * A;
a0 =  1 + alpha / A;
a1 = -2 * cos(w0);
a2 =  1 - alpha / A;

b = [b0, b1, b2] / a0;
a = [a0, a1, a2] / a0;
end
