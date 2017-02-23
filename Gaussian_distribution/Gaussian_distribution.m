function fx_Gaussian = Gaussian_distribution( x,u,o ) % x= x axle, u = expectation, o= variance
%GAUSSIN_ Summary of this function goes here
%   Detailed explanation goes here
 fx_Gaussian = 1/(sqrt(2*pi*o))*exp(-(x-u)^2/(2*o));
end

