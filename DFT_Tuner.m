% Samuel Stone and Isaac Lawson-Hughes
function fo_est = DFT_Tuner(x,b_E,b_A,b_D)
% First, Find the DFT of x and each filter
% See NS_29 3/16
Nzp = 2^15;
X = fftshift(fft(x,Nzp));
B_E = fftshift(fft(b_E,Nzp));
B_D = fftshift(fft(b_D,Nzp));
B_A = fftshift(fft(b_A,Nzp));
% Find the product of the signal and the filter
y_E = X.*B_E;
y_A = X.*B_A;
y_D = X.*B_D;

% Find the power of each output with sum of squares
power_E = sum(y_E.^2)/size(y_E,2);
power_A = sum(y_A.^2)/size(y_A,2);
power_D = sum(y_D.^2)/size(y_D,2);
comp = [power_E power_A power_D];
ref = [82.41 110 146.83];
[v,ind] = max(comp);
fo_est = ref(ind);
end