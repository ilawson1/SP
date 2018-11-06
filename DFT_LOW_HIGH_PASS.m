% Samuel Stone and Isaac Lawson-Hughes
function [b_LP,b_HP] = DFT_LOW_HIGH_PASS()
rp=1; rs=60; % specify passband ripple & stopband attenuation in dB

AA_HIGH=[0 1]; %%% specfies that you want a bandpass filter
dev_HIGH=[(10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20)]; % parm. needed by design routine
% See NS_28 7/14 for above %
AA_LOW = fliplr(AA_HIGH);
dev_LOW = fliplr(dev_HIGH);
Fs=4410; % Sampling frequency
TBW = 10; % Transition band width in Hz picked to bring N below 1000

f_spec_LP = [68-TBW 68];
f_spec_HP = [165 165+TBW];


[N,fo,ao,w] = firpmord(f_spec_LP,AA_LOW,dev_LOW,Fs);
b_LP = firpm(N,fo,ao,w);
[N,fo,ao,w] = firpmord(f_spec_HP,AA_HIGH,dev_HIGH,Fs);
b_HP = firpm(N,fo,ao,w);

end