ir = zeros(1, 50000);
ir([1, 1000, 5000, 10000, 15000]) = [1, 0.8, 0.7, 0.6, 0.5];% create an impulse response
[sig, fs] = audioread('pluck.wav'); %Read Signal
%sound(sig,fs);
y = conv(sig, ir); % convolve the two signals
%sound(y,fs);
subplot(211), plot(sig);
subplot(212), plot(y);
% plot both signals on same figure.