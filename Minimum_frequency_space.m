clc
close all
clear all

% Minimum frequency seperation between two sinusoidals
fs=100;
T=1;
ts=1/fs;
t=[0:ts:T];

% with random phase
f1=1;
f2=2;
phi = 2*pi*rand; % uniformly distributed from 0 tp 2pi
s1=cos(2*pi*f1*t+phi);
s2=cos(2*pi*f2*t);
sum_with_phi_random=sum(s1.*s2);

% with zero phase difference
f3=3/4;
f4 =5/4;
s3=cos(2*pi*f3*t);
s4=cos(2*pi*f4*t);
sum_with_phi_zero=sum(s3.*s4);

figure
plot(t,s1,'b.-')
hold on
plot(t,s2,'rx-')
legend('s1','s2')
plot(t,sum_with_phi_random);
title('Minimum frequency seperation for random phase')
grid on
xlabel('time')
ylabel('amplitude')

figure
plot(t,s3,'b.-')
hold on
plot(t,s4,'rx-')
legend('s3','s4')
title('Minimum frequency seperation for zero phase')
grid on
xlabel('time')
ylabel('amplitude')