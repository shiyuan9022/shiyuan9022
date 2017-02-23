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
X=fft(x,N)/fs;%����ʱ���������һ�� 1/Ts��˥�������Ա������TsҲ������fs
df=fs/N; %Ƶ�ʷֱ���
f=[0:df:df*(N-1)]-fs/2;%Ƶ�ʵ�ת  
%����Ƶ��ͼ  
subplot(2,1,2);
plot(f,fftshift(abs(X)));%�����ݡ�ѭ����ת��  
title('fouier transform');