function hamming_test(N)
w = hamming(N);
w = w.';
W = fftshift(fft(w,2^15));
f = 0:(N-1);
figure; plot(f,w)
t = 1:size(W,2);
figure; plot(t,20*log10(abs(W)));
axis([0 size(W,2) -100 50])
figure; zplane(w);


end