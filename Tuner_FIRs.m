% Samuel Stone and Isaac Lawson-Hughes
function [b_E,b_A,b_D] = Tuner_FIRs()
rp=1; rs=60; % specify passband ripple & stopband attenuation in dB

AA=[0 1 0]; %%% specfies that you want a bandpass filter
dev=[(10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20) (10^(rp/20)-1)/(10^(rp/20)+1)]; % parm. needed by design routine
% See NS_28 7/14 for above %
Fs=4410; % Sampling frequency
TBW = 10; % Transition band width in Hz

f_spec_E = PassBand(68,(110+82.41)/2, TBW);
f_spec_A = PassBand((110+82.41)/2,(146.83+110)/2, TBW);
f_spec_D = PassBand((146.83+110)/2,165, TBW);

[N,fo,ao,w] = firpmord(f_spec_E,AA,dev,Fs);
b_E = firpm(N,fo,ao,w);
% [N,fo,ao,w] = firpmord(f_spec_A,AA,dev,Fs);
% b_A = firpm(N,fo,ao,w);
% [N,fo,ao,w] = firpmord(f_spec_D,AA,dev,Fs);
% b_D = firpm(N,fo,ao,w);

end