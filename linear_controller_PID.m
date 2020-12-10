%% Trial linear controller <-> © SM Haider Ali Shuvo , Redistributable Under Apache License
clc;clear all;close all;
%% Parameters
Rlung = 5/1000 ; Clung = 20 ; Rleak = 60/1000 ; Rhose = 4.5/1000 ; wn = 2*pi*30 ;

Ah = -(1/Rhose + 1/Rleak) / (Rlung*Clung*(1/Rlung + 1/Rhose + 1/Rleak));
Bh = (1/Rhose) / (Rlung*Clung*(1/Rlung + 1/Rhose + 1/Rleak));
Ch1 = (1/Rlung)/((1/Rlung + 1/Rhose + 1/Rleak));
Dh1 = (1/Rhose)/((1/Rlung + 1/Rhose + 1/Rleak));
Ch2 = -(1/Rhose + 1/Rleak) / (Rlung*(1/Rlung + 1/Rhose + 1/Rleak)) ;
Dh2 = (1/Rhose) / (Rlung*(1/Rlung + 1/Rhose + 1/Rleak));
%% pset
t = 0:.001:16;
pset = ones(length(t),1)*5;
pset(t>1 & t<1.2) = 75*t(t>1 & t<1.2)-70;
pset(t>=1.2 & t<5)=20;
pset(t>10 & t<10.2)= 75*t(t>1 & t<1.2)-70 ;
pset(t>=10.2 & t<15)=20;
plot(t,pset,'b');
%%
s = tf('s');
B = wn^2 / (s^2+2*wn*s+wn^2);
T = (Dh1*(s-(Ah-(Ch1*Bh)/Dh1)) / (s-Ah))*B;
controller = ((s+.1)*(s+377))/s ;
rlocus(T*controller);
sgrid(.8261,0);
[k poles] = rlocfind(T*controller);
%% k= .0091 can be a default good choice if you are unable to adjust 
sys = feedback(k*controller*T,1) + feedback(k*controller*T,1)/(k*controller) ;
[y t x] = lsim(sys , pset , t);
figure ; plot(t,y,'r',t,pset,'b');hold on;
%%
T_f = (Dh2*(s-(Ah-(Ch2*Bh)/Dh2)) / (s-Ah))*B;
%%
sys = feedback(k*controller*T,1) + feedback(k*controller*T,1)/(k*controller) ;
[y t x] = lsim(sys , pset , t);
sys_f_1 = (1+controller*k)*T_f ; 
sys_f_2 = -controller*k*T_f;
[y_f1 t x] = lsim(sys_f_1 , pset , t);
[y_f2 t x] = lsim(sys_f_2 , y , t);
figure;
plot(t,(y_f1+y_f2)*60 , 'b'); hold on;