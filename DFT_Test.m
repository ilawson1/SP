function DFT_Test(fo)
[x,X]=DFT_Synth_Guitar(fo);
[x_E,x_A,x_D] = DFT_Real_Guitar();
[b_E,b_A,b_D] = Tuner_FIRs();

DFT_Tuner(x_D,b_E,b_A,b_D);

end
