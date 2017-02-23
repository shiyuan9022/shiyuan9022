clc
clear all
fs=10;%sample rate
ts=1/fs;%sample interval
t=[-5:ts:5];%total time
x=zeros(size(t));
x(41) = 0.5;  
x(42:60) = ones(1,19);  
x(61) = 0.5;
%x = 2*sinc(2*t);
subplot(2,1,1)
plot(t,x);
title('rectangular wave in time domain');
xlabel('t');
ylabel('x(t) amplitude ');

N=4096;
X=fft(x,N)/fs;%由于时域抽样会有一个 1/Ts的衰减，所以必须乘以Ts也即除以fs
df=fs/N; %频率分辨率
f=[0:df:df*(N-1)]-fs/2;%频率倒转  
%绘制频谱图  
subplot(2,1,2);
plot(f,fftshift(abs(X)));%把数据‘循环倒转’  
title('fouier transform');