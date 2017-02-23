clc;
clear all;
tic
x = -5:0.001:5;
x_length = length(x);
u = zeros(1,length(x));
a = zeros(x_length);
b = zeros(x_length);
c = zeros(x_length);
o_a = 0.2*ones(1,length(x));
o_b = ones(1,length(x));
o_c = 5*ones(1,length(x));

% aa= 1./(sqrt(2*pi.*o_a));
% bb = exp(-(x-u).^2);
% 
% cc =(2*o_a);


a = 1./(sqrt(2*pi.*o_a)).*(exp(-(x-u).^2./(2*o_a)));
b = 1./(sqrt(2*pi.*o_b)).*(exp(-(x-u).^2./(2*o_b)));
c = 1./(sqrt(2*pi.*o_c)).*(exp(-(x-u).^2./(2*o_c)));

plot(x,a,'b',x,b,'c',x,c,'r')
grid on

toc