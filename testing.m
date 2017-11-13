clc; clear all; close all;

seed = rng;
rounds = 10000;
alim = 1;
blim = 1;


scores = Gameplay(seed,rounds,alim,blim);
x = (1:rounds);
plot(x,scores(:,1),'g',x,scores(:,2),'r',x,scores(:,3),'b');