close all;

seed = 0;
rounds = 1000;
n = 5;
fun = @(n) rand(n) -0.5;
delta_min = 0;
delta_max = 1;

Delta_Spectrum(seed,rounds,delta_min,delta_max,fun,fun,n);