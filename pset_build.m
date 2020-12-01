clc;clear all;close all;
t = 0:.001:16;
pset = ones(length(t),1)*5;
pset(t>1 & t<1.2) = 75*t(t>1 & t<1.2)-70;
pset(t>=1.2 & t<5)=20;
pset(t>10 & t<10.2)= 75*t(t>1 & t<1.2)-70 ;
pset(t>=10.2 & t<15)=20;
plot(t,pset,'b');

pset_sim = [t' pset];