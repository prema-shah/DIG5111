% task1_ism_starter.m
% DIG5111 Assessment Task 1: Image Source Method
%
% This script implements a first-order 2D image source model and convolves
% the resulting IR with a dry signal. It runs as-is and produces a working
% output.
%
% Your task is to extend and analyse it:
%   - Add higher-order reflections (see Section 4)
%   - Compute RT60 and the energy decay curve (see Section 6)
%   - Run a comparative study varying room and absorption parameters
%
% Reference: ISMNotes.pdf (distributed with the assessment materials)
% -------------------------------------------------------------------------

clear; close all;

%% =========================================================================
%  Section 1 — Room and Signal Parameters
%  =========================================================================

fs = 44100;   % sample rate (Hz)
c  = 343;     % speed of sound (m/s) — keep as a named constant

% 2D rectangular room (metres)
W = 8;    % width  (x-axis)
D = 5;    % depth  (y-axis)

% Source and receiver positions (metres)
xs = 2.0;   ys = 1.5;
xr = 5.5;   yr = 3.0;

% IR length — long enough to capture all reflections of interest
ir_len = round(0.05 * fs);          % 50 ms
ir     = zeros(1, ir_len);

%% =========================================================================
%  Section 2 — Direct Path
%  =========================================================================

r_dir = sqrt((xs - xr)^2 + (ys - yr)^2);
d_dir = round(r_dir / c * fs);
g_dir = 1 / r_dir;

if d_dir >= 1 && d_dir <= ir_len
    ir(d_dir) = ir(d_dir) + g_dir;
end

%% =========================================================================
%  Section 3 — First-Order Image Sources
%  =========================================================================
%
% For a 2D room with source at (xs, ys), the four first-order image
% positions are found by mirroring the source through each wall.
% See ISMNotes.pdf Section 2 for the geometry.

images = [-xs,     ys;       % left wall   (x = 0)
           2*W-xs, ys;       % right wall  (x = W)
           xs,    -ys;       % front wall  (y = 0)
           xs,     2*D-ys];  % back wall   (y = D)

% Wall absorption coefficients (0 = fully absorbing, 1 = perfectly reflective)
alpha = [0.8, 0.8, 0.9, 0.9];   % [left, right, front, back]

for k = 1:size(images, 1)
    r = sqrt((images(k,1) - xr)^2 + (images(k,2) - yr)^2);
    d = round(r / c * fs);
    g = alpha(k) / r;
    if d >= 1 && d <= ir_len
        ir(d) = ir(d) + g;
    end
end

%% =========================================================================
%  Section 4 — Higher-Order Image Sources  (your work)
%  =========================================================================
%
% The closed-form indexing scheme for all 2D images up to order N is:
%
%   S'(p,q) = ( 2*p*W + (-1)^p * xs,   2*q*D + (-1)^q * ys )
%
% where p and q are integers. Iterating over all (p,q) with |p|+|q| <= N
% and skipping (0,0) gives all reflections up to order N.
% See ISMNotes.pdf Section 3 for the derivation.
%
% For a higher-order path, the gain requires the absorption coefficient of
% every wall the path has touched. A useful approximation for the
% closed-form scheme is a mean absorption raised to the number of bounces.
%
% Extend the code here to include second- and third-order reflections.
% You will need to make ir_len longer to capture them all.

%% =========================================================================
%  Section 5 — Plot and Listen
%  =========================================================================

t_ir = (0:ir_len-1) / fs * 1000;   % ms

figure;
stem(t_ir, ir, 'filled', 'MarkerSize', 3);
xlabel('Time (ms)');  ylabel('Amplitude');
title('Synthetic Room Impulse Response');

% Generate a dry signal and convolve with the room IR
[x, ~] = generate_sinusoid(fs, 1, 440, 0, 1);
y = conv(x, ir, 'same');

% Uncomment to listen:
% soundsc(x, fs);   pause(1.5);
% soundsc(y, fs);

%% =========================================================================
%  Section 6 — Analysis  (your work)
%  =========================================================================

% --- Frequency response ---
% Plot the magnitude spectrum of the IR in dB using plot_spectrum().
% What does it tell you about how the room colours the sound?



% --- RT60 ---
% The reverberation time RT60 is the time for IR energy to decay by 60 dB.
% Compute it from the energy decay curve (EDC), which is the backward
% cumulative sum of the squared IR. See ISMNotes.pdf Section 9 for
% the formula and a short MATLAB example.



% --- Comparative study ---
% Vary one parameter at a time, re-run, and note the effect on the IR,
% the spectrum, and the RT60. Suggested variables to explore:
%
%   Room size          — change W and D
%   Absorption         — change alpha values (try near-0 and near-1)
%   Reflection order   — compare 1st, 2nd, 3rd order
%   Source/receiver    — move xs, ys, xr, yr and observe early reflection pattern
%
% For each variation, report: how RT60 changes, how the IR density changes,
% and what the convolved signal sounds like.
