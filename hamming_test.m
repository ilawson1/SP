function hamming_test(N)
w = hamming(N);
w = w.';
f = 0:(N-1);
figure; plot(f,w)