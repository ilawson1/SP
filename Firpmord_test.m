rp=1; rs=60; % specify passband ripple & stopband attenuation in dB
f_spec=[0.3 0.31 .39 .4]; % specify passband and stopband edges in normalized DT freq
AA=[0 1 0]; %%% specfies that you want a bandpass filter
dev=[(10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20) (10^(rp/20)-1)/(10^(rp/20)+1)]; % parm. needed by design routine
Fs=2; % “Fake” value for Fs so our design is done in terms of normalized DT freq
[N,fo,ao,w]=firpmord(f_spec,AA,dev,Fs);
% estimates filter order and gives other parms needed to run firpm
b=firpm(N,fo,ao,w); % Computes the designed filter coefficients in vector b
figure;freqz(b,1)
t=1:size(b,2);
figure; plot(t,b);
B = fftshift(fft(b,2^15));
t1 = 1:size(B,2);
figure;plot(t1,10*log(abs(B))/log(10));