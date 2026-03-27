% task3_eq_starter.m
% DIG5111 Assessment Task 3: Corrective EQ
%
% This script simulates a hardware device with a coloured frequency response
% and plots that response. It runs as-is.
%
% Your task is to design a correction filter to flatten the response:
%   1. Design an FIR correction filter (regularised inversion or fir2)
%   2. Design an IIR correction filter using cascaded peaking biquads
%   3. Verify that hardware + correction gives a flat combined response
%   4. Compare the two approaches (accuracy, phase, latency, cost)
%
% If you have access to a hardware device to measure, see Section 5.
%
% Reference: EQNotes.pdf (distributed with the assessment materials)
% Helper:    peaking_biquad.m
% -------------------------------------------------------------------------

clear; close all;

fs   = 44100;
NFFT = 2^14;

%% =========================================================================
%  Section 1 — Simulated Hardware Colouration
%  =========================================================================
%
% Two peaking biquad sections create a known colouration to correct.
% peaking_biquad(f0, Q, gain_dB, fs) is provided in peaking_biquad.m.

[b1, a1] = peaking_biquad(600,  1.0, +6.0, fs);   % resonance at 600 Hz
[b2, a2] = peaking_biquad(7000, 1.5, -4.0, fs);   % rolloff at 7 kHz

% Generate the hardware IR from a unit impulse
impulse = [1, zeros(1, 4095)];
h_hw    = filter(b1, a1, impulse);
h_hw    = filter(b2, a2, h_hw);

%% =========================================================================
%  Section 2 — Frequency Response Estimate
%  =========================================================================

H_hw    = fft(h_hw, NFFT);
mag     = abs(H_hw(1:NFFT/2+1));
mag_db  = 20*log10(mag / max(mag) + 1e-12);
freq_hz = (0:NFFT/2) * fs / NFFT;
freq    = freq_hz / (fs/2);                  % normalised (0 to 1) for fir2

figure;
semilogx(freq_hz, mag_db, 'b', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');  ylabel('Magnitude (dB)');
title('Simulated Hardware Response');
xlim([20, fs/2]);  ylim([-15, 10]);  grid on;

%% =========================================================================
%  Section 3 — FIR Correction Filter  (your work)
%  =========================================================================
%
% Design a linear-phase FIR filter whose response is the inverse of the
% hardware response measured above.
%
% Two approaches are described in EQNotes.pdf Section 5:
%
%   Option A — Regularised inversion
%     Compute the conjugate of H_hw divided by (|H_hw|^2 + epsilon).
%     Take the IFFT, truncate to N_fir taps, and apply a Hann window.
%     The regularisation constant epsilon limits boosting at deep notches.
%
%   Option B — fir2 (Signal Processing Toolbox)
%     Supply fir2 with the normalised frequency vector (freq) and a target
%     magnitude equal to the reciprocal of the measured response.
%
% After designing the filter, compute its frequency response and plot it
% alongside the hardware response to check they are mirror images.



%% =========================================================================
%  Section 4 — IIR Correction Filter  (your work)
%  =========================================================================
%
% Use cascaded peaking biquad sections to correct the most prominent
% features of the hardware response. For each feature:
%   - Estimate the centre frequency and approximate gain error from the plot
%   - Choose a Q that matches the width of the feature
%   - Apply the opposite gain (correct a +6 dB peak with -6 dB, and so on)
%
% Use peaking_biquad.m to compute the coefficients. Apply sections in series
% with filter(). See EQNotes.pdf Section 6 for the cascade structure.
%
% Start with one section per prominent peak or dip. Only add more sections
% if the combined response still shows significant error.



%% =========================================================================
%  Section 5 — Verification  (your work)
%  =========================================================================
%
% For each filter (FIR and IIR):
%   - Compute its frequency response (fft of the filter impulse response)
%   - Add the correction response (dB) to the hardware response (dB)
%   - Plot all three curves on one figure: hardware, correction, combined
%
% The combined response should be close to 0 dB across the main band.
% Compute the RMS residual error between 100 Hz and 10 kHz and report it.
%
% Discuss the differences between FIR and IIR in your report:
%   accuracy, phase linearity, latency, and computational cost.



%% =========================================================================
%  Section 6 — Real Hardware Measurement  (optional)
%  =========================================================================
%
% If you have access to a device to measure:
%
%   1. Generate a test signal (log-swept sine recommended) and play it
%      through the hardware. Record the output with the same audio interface.
%      Keep gain settings fixed throughout all measurements.
%
%   2. Estimate the device IR by deconvolution: divide the FFT of the
%      recording by the FFT of the reference signal.
%
%   3. Window the IR with a short Hann window (10-20 ms) to remove room
%      reflections before the first reflection arrives. See EQNotes.pdf
%      Section 3 for the windowing procedure and the length trade-off.
%
%   4. Proceed with Sections 3-5 using the windowed hardware IR in place of
%      h_hw. The filter design and verification steps are identical.
%
% Note: below the Schroeder frequency (~200 Hz in a typical room) room modes
% dominate the measurement and EQ correction is unreliable. See EQNotes.pdf
% Section 8 for the Schroeder frequency estimate.
