clc;
clear all;
tic
x = -5:0.001:5;
x_length = length(x);
a = zeros(x_length);
b = zeros(x_length);
c = zeros(x_length);
% d = zeros(x_length);
% e = zeros(x_length);
% f = zeros(x_length);
% g = zeros(x_length);

for i = 1:x_length
    
    a(i) = Gaussian_distribution(x(i),0,0.2);
    b(i) = Gaussian_distribution(x(i),0,1);
    c(i) = Gaussian_distribution(x(i),0,5);
    
    % d(i) = Gaussian_distribution(x(i),-3,1);
    % e(i) = Gaussian_distribution(x(i),-1,1);
    % f(i) = Gaussian_distribution(x(i),0,1);
    % g(i) = Gaussian_distribution(x(i),3,1);
    
end

figure(1)
plot(x,a,'b',x,b,'c',x,c,'r')

% figure(2)
% hold on
% plot(x,d,'b',x,e,'c',x,f,'r',x,g,'k')
% hold off;

grid on

toc

