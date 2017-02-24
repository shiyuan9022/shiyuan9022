clc;
clear all;

rng('default') %seed
bit_length = 10^6; %number of bits or symbols
bit = randi([0,1],1,bit_length); % generating 0,1 with 
symbol = 1-2*bit; % 0 to 1, 1 to -1
n = 1/sqrt(2)*[randn(1,bit_length) + 1i*randn(1,bit_length)]; % white gaussian noise, 0dB variance 
   

