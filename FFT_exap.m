clc;
clear all;
fs=400;
ts=1/fs;
t=[-0.1:ts:0.1];
x=0.5*sin(2*pi*15*t)+2*sin(2*pi*40*t);
N=400;
X=fft(x,N);
df=fs/N;
f=[0:df:df*(N-1)]-fs/2;
plot(f,fftshift(abs(X)));grid on;