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
%y_All = filter(b_A,1,filter(b_D,1,y_E));
[b_LP,b_HP] = DFT_LOW_HIGH_PASS();
LP = filter(b_LP,1,x);
HP = filter(b_HP,1,x);
% Find the power of each output with sum of squares
power_E = sum(y_E.^2)/length(y_E)
power_A = sum(y_A.^2)/length(y_A)
power_D = sum(y_D.^2)/length(y_D)
%power_All =sum(y_All.^2)/length(y_All);
%power_None = sum(x.^2)/length(X);
power_LP = sum(LP.^2)/length(LP);
power_HP = sum(HP.^2)/length(HP);
comp = [power_E ;power_A; power_D;power_LP;power_HP];
ref = [b_E; b_A; b_D];
f_ref = [82.41; 110; 146.83];
[v,ind] = max(comp); % v is unused
% if(ind > 3)
%     fo_est = NaN;
%     if(ind == 4)
%         disp('Freq. Far too Low');
%     end
%     if(ind == 5)
%         disp('Freq. Far too High');
%     end
%     return
% end
b = ref(ind,:); %The correct band
ind;
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
title('Frequecy domain view of input signal and estimated frequency');
xlim([0 Fs/2]);
lower = 1*min(20*log10((abs(Y_H_S))))
upper = 1.2*max(20*log10((abs(Y_H_S))))
ylim ([lower upper]);
results = {['Estimated Frequency: ',num2str(fo_est),'Hz'],['    If f1 is ',num2str(f1),'Hz, f2/f1 is ',num2str(d),'Cents']};
text((0.005*length(Y_H_S))+fo_est,20*log10(Y_H_S(maxPos)),results);

end