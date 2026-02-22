amp = 0.9
f=440
fs = 44100
dur = 1
n = 0:round(dur*fs)-1;
t=n/fs;
theta = 0
sig = amp*sin(2*pi*f*t + theta)
soundsc(sig, fs);
plot(t, sig)
xlabel("Time")
ylabel("Amplitude")
title
grid on