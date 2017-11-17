% Sam Stone and Isaac Lawson-Hughes
function DTF_Real_Guitar()
Fs = 4410;
T = 1/Fs;
x_E = audioread('E_string.wav');
x_A = audioread('A_string.wav');
x_D = audioread('D_string.wav');
figure;
t_A = 0:T:(size(x_A,2)-1);
t_D = 0:T:(size(x_D,2)-1);
t_E = 0:T:(size(x_E,2)-1);'
subplot(3,1,1); plot(t_E,x_E);
title('E');
subplot(3,1,2); plot(t_A,x_A)
title('A');
subplot(3,1,3); plot(t_D,x_D)
title('D');

