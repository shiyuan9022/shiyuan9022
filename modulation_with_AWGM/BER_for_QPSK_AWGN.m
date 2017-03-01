
clc
clc;
clear all;
 
tic
Eb_No_start = -3;
Eb_No_delta = 0.5;
Eb_No_stop = 18;
BER_stop = 1e-5;

% Setup the SNR for the first iteration of the loop.
Eb_No_count = 1;
Eb_No = Eb_No_start;
BER = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate bits
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rng('default') %seed
bit_length = 10^6; %number of bits
bit_genreated = randi([0,1],1,bit_length); % generating 0,1 at uniform distribution
bit_received = zeros(1,bit_length);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bit to symbol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%split bit_genreated to 2 control bits, ab(00,01,11,10)
bit_a = bit_genreated(1:2:end);%0:j,1:-j
bit_b = bit_genreated(2:2:end);%0:1,1:-1
symbol_temp = 1-2*bit_b+1i*(1-2*bit_a); %non-nomalization
sigma_x = std(symbol_temp);
symbol = symbol_temp/sigma_x ;% nomalized symbol, power of symbols = 1
bit_per_symbol=bit_length/numel(symbol);
% Loop until the job is killed or until the SNR or BER target is reached.
while Eb_No <= Eb_No_stop && BER >= BER_stop
    
    % Convert from SNR (in dB) to noise power spectral density.
    
    % Counters to store the number of errors and bits simulated so far.
    error_count=0;
    bit_count=0;
    
    % Keep going until enough errors have been observed. This runs the simulation only as long as is required to keep the BER vs SNR curve smooth.
    while error_count < 100
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % AWGN Generator
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sigma_n = 1/sqrt(2*(10^((Eb_No + 10*log10(bit_per_symbol))/10)));
        n = sigma_n*[randn(1,bit_length/bit_per_symbol) + 1i*randn(1,bit_length/bit_per_symbol)]; %#ok<NBRAK> % white gaussian noise
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Add AWGN
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        symbol_received = symbol + n;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %symbol to bit
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %         symbol_received_a = imag(symbol_received);
        %         symbol_received_b = real(symbol_received);      
        bit_received_a = imag(symbol_received)<=0;
        bit_received_b = real(symbol_received)<=0;
        
        bit_received_temp=[bit_received_a;bit_received_b];
        bit_received=reshape(bit_received_temp,1,bit_length);
%         bit_received=reshape([bit_received_a;bit_received_b],1,bit_length);
        
        % Accumulate the number of errors and bits that have been simulated so far.
        delayB = 0;
        error_count = error_count + sum(bit_received(delayB+1:end) ~= bit_genreated(1:end-delayB));
        bit_count = bit_count + bit_length;
    end
    
    % Calculate the BER.
    BER = error_count/bit_count;
    
    % Store the SNR and BER in a matrix and display it.
    results(Eb_No_count,1) = Eb_No;
    results(Eb_No_count,2) = BER %#ok<NOPTS>
    
    % Plot the results. This will be ignored on Lyceum.
    hold on;
    semilogy(results(:,1),results(:,2),'b.-');
    title('QPSK modulation in an AWGN channel');
    ylabel('BER');
    xlabel('Eb/N0 (in dB)');
    if  BER_stop ~= 0
        ylim([BER_stop,1]);
    end
    if Eb_No_stop ~= inf
        xlim([Eb_No_start, Eb_No_stop]);
    end
    grid on
    % Setup the SNR for the next iteration of the loop.
    Eb_No = Eb_No + Eb_No_delta;
    Eb_No_count = Eb_No_count + 1;
end
toc