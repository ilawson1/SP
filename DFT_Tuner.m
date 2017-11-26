% Samuel Stone and Isaac Lawson-Hughes
function fo_est = DFT_Tuner(x,b_E,b_A,b_D)
%% Finding the right range
% First, Find the DFT of x and each filter
% See NS_29 3/16
Nzp = 2^16;
Fs = 4410;
y_E = filter(b_E,1,x);
y_A = filter(b_A,1,x);
y_D = filter(b_D,1,x);
% Find the power of each output with sum of squares
power_E = sqrt(sum(y_E.^2))/length(y_E);
power_A = sqrt(sum(y_A.^2))/length(y_A);
power_D = sqrt(sum(y_D.^2))/length(y_D);
comp = [power_E ;power_A; power_D];
ref = [b_E; b_A; b_D];
f_ref = [82.41 110 146.83];
[v,ind] = max(comp); % v is unused
b = ref(ind); %The correct band
ind
f1 = f_ref(ind);
%% DFT Processing stuff
L  = length(x);
w = hamming(L)';
x_h = x.*w; %Apply Hamming window
y_h = filter(b,1,x_h); %Apply filter to hamming x
Y_H = fftshift(fft(y_h,Nzp));


%% 
delta = 100;
Y_H_S = abs(Y_H((length(Y_H)/2):length(Y_H))); % Look only at the second half of of Y and take the absolute value
[v,maxPos] = max(Y_H_S);
fo_est = maxPos/Nzp*Fs;
disp(['Estimated Frequency: ',num2str(fo_est)]);
% Distance in cents
d = 1200*log2(fo_est/f1);
disp(['Distance in Cents ',num2str(d)]);

figure; plot((1:length(Y_H_S))./Nzp.*Fs,20*log10(Y_H_S));
hold on
plot(fo_est, 20*log10((Y_H_S(maxPos))),'o','markeredgecolor','r');
results = {['Estimated Frequency: ',num2str(fo_est),'Hz'],['    If f1 is ',num2str(f1),'Hz, f2/f1 is ',num2str(d),'Cents']};
text((0.005*length(Y_H_S))+fo_est,20*log10(Y_H_S(maxPos)),results);
%% Test Thing
nF = fftshift(fft(x_h,Nzp));
nF = nF((length(nF)/2):length(nF));
F = fftshift(fft(y_h,Nzp));
F = F((length(F)/2):length(F));
figure;
subplot(3,1,1); plot((1:length(nF))./Nzp.*Fs,20*log10(abs(nF)));
title('nF');
subplot(3,1,2); plot((1:length(F))./Nzp.*Fs,20*log10(abs(F)));
title('F');
D = nF-F;
subplot(3,1,3); plot((1:length(D))./Nzp.*Fs,20*log10(abs(D)));
title('D');
end