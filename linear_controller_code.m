%% Trial 1 <-> © SM Haider Ali Shuvo , Redistributable Under Apache License
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
controller = 1/s ;
rlocus(T*controller);

%%
ki = 0.00000000001 ; eps=1e-8 ;
sys = feedback(ki*controller*T,1) + feedback(ki*controller*T,1)/(ki*controller) ;
[y t x] = lsim(sys , pset , t);
figure ; plot(t,y,'r',t,pset,'b');hold on;
%%
ki = 0.4 ;
sys = feedback(ki*controller*T,1) + feedback(ki*controller*T,1)/(ki*controller) ;
[y t x] = lsim(sys , pset , t);
plot(t,y,'y');hold on;
%%
ki = 10 ;
sys = feedback(ki*controller*T,1) + feedback(ki*controller*T,1)/(ki*controller) ;
[y t x] = lsim(sys , pset , t);
plot(t,y,'g');hold on;
legend('ki=0','pset','ki=0.4','ki=10');
%% Get Flow Response
T_f = (Dh2*(s-(Ah-(Ch2*Bh)/Dh2)) / (s-Ah))*B;
%%
ki = 0.00000000001 ; eps=1e-8 ;
sys = feedback(ki*controller*T,1) + feedback(ki*controller*T,1)/(ki*controller) ;
[y t x] = lsim(sys , pset , t);
sys_f_1 = (1+controller*ki)*T_f ; 
sys_f_2 = -controller*ki*T_f;
[y_f1 t x] = lsim(sys_f_1 , pset , t);
[y_f2 t x] = lsim(sys_f_2 , y , t);
figure;
plot(t,(y_f1+y_f2)*60 , 'b'); hold on;
%%
ki = .4 ; eps=1e-8 ;
sys = feedback(ki*controller*T,1) + feedback(ki*controller*T,1)/(ki*controller) ;
[y t x] = lsim(sys , pset , t);
sys_f_1 = (1+controller*ki)*T_f ; 
sys_f_2 = -controller*ki*T_f;
[y_f1 t x] = lsim(sys_f_1 , pset , t);
[y_f2 t x] = lsim(sys_f_2 , y , t);
plot(t,(y_f1+y_f2)*60 , 'r'); hold on;
%%
ki = 10 ; eps=1e-8 ;
sys = feedback(ki*controller*T,1) + feedback(ki*controller*T,1)/(ki*controller) ;
[y t x] = lsim(sys , pset , t);
sys_f_1 = (1+controller*ki)*T_f ; 
sys_f_2 = -controller*ki*T_f;
[y_f1 t x] = lsim(sys_f_1 , pset , t);
[y_f2 t x] = lsim(sys_f_2 , y , t);
plot(t,(y_f1+y_f2)*60 , 'g'); hold on; 
legend('ki=0','ki=.4','ki=10');