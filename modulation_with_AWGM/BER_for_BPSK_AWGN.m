clc;
clear all;

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bit to symbol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
symbol = 2*bit_genreated-1; % 0 to -1, 1 to 1
bit_per_symbol=numel(symbol)/bit_length;
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
        sigma_x = std(symbol);
        sigma_n = 1/sqrt(2*(10^((Eb_No + 10*log10(bit_per_symbol))/10)));
        n = sigma_x*sigma_n*[randn(1,bit_length) + 1i*randn(1,bit_length)]; % white gaussian noise
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Add AWGN 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        symbol_received = symbol + n;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %symbol to bit 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        bit_received = real(symbol_received)>=0;
        
        
        % Accumulate the number of errors and bits that have been simulated so far.
        delayB = 0;
        error_count = error_count + sum(bit_received(delayB+1:end) ~= bit_genreated(1:end-delayB));
        bit_count = bit_count + bit_length;
    end
    
    % Calculate the BER.
    BER = error_count/bit_count;
    
    % Store the SNR and BER in a matrix and display it.
    results(Eb_No_count,1) = Eb_No;
    results(Eb_No_count,2) = BER
    
    % Plot the results. This will be ignored on Lyceum.
    semilogy(results(:,1),results(:,2),'b.-');
    title('BPSK modulation in an AWGN channel');
    ylabel('BER');
    xlabel('Eb/N0 (in dB)');
    if  BER_stop ~= 0
        ylim([BER_stop,1]);
    end
    if Eb_No_stop ~= inf
        xlim([Eb_No_start, Eb_No_stop]);
    end
    grid
    % Setup the SNR for the next iteration of the loop.
    Eb_No = Eb_No + Eb_No_delta;
    Eb_No_count = Eb_No_count + 1;
end
