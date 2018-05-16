clc;
clear all;
close;

n = 2;
delta_max = 1;
delta_min = 0;
dist = 1;
rounds = 1000;
seed = 0;

switch dist
    case 1 %exponential lambda = 1
        fun = @(x) exprnd(1,x,x)-2;
    case 2 %uniform [-.5,.5]
        fun = @(x) rand(x) -.5 ;
    case 3 %normal
        fun = @(x) randn(x) ;
    otherwise
        ME = Exception('Undefined Distribution');
        throw(ME);
end

Delta_Spectrum(seed,rounds,delta_min,delta_max,fun,fun,n);
