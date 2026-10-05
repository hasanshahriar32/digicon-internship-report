clear ;
clc ;
close all ;
%% =========================================================
% OPTICAL COMMUNICATIONS LABORATORY
% PIN and APD Receivers
% Noise , SNR , Q - factor and BER
% ==========================================================
% % Fundamental Constants
q
h
c
kB

=
=
=
=

1.602 e -19;
6.626 e -34;
3 e8 ;
1.381 e -23;

%
%
%
%

Electron charge ( C )
Planck constant ( J . s )
Speed of light ( m / s )
Boltzmann constant ( J / K )

%% =========================================================
% RECEIVER PARAMETERS
% ==========================================================
lambda = 1550 e -9;

% Wavelength ( m )

eta = 0.80;

% Quantum efficiency

% Photodetector responsivity
R = eta * q * lambda /( h * c ) ;
B = 1 e9 ;

% Noise - equivalent bandwidth ( Hz )

T = 300;

% Temperature ( K )

RL = 1000;

% Load resistance ( Ohm )

Id = 5e -9;

% Dark current ( A )

%% =========================================================
% RECEIVED OPTICAL POWER
% ==========================================================
% Optical power corresponding to OOK bit 1
P1dBm = -50:0.2: -15;
% Convert dBm to Watt
P1 = 1e -3 * 10.^( P1dBm /10) ;

%% =========================================================
% THERMAL NOISE VARIANCE
% ==========================================================
thermalVar = ...
4* kB * T * B / RL ;

%% =========================================================


% PIN RECEIVER
% ==========================================================
% Signal current for bit 1
signalPIN = R * P1 ;
% Noise standard deviation for bit 0
sigma0PIN = sqrt ( ...
2* q * Id * B + thermalVar ) ;
% Noise standard deviation for bit 1
sigma1PIN = sqrt ( ...
2* q *( R * P1 + Id ) * B + thermalVar ) ;
% Q - factor
QPIN = ...
signalPIN ./ ( sigma1PIN + sigma0PIN ) ;
% BER
BERPIN = ...
0.5 * erfc ( QPIN / sqrt (2) ) ;

%% =========================================================
% APD RECEIVER
% ==========================================================
M = 10;

% APD multiplication gain

kA = 0.30;

% Ionization coefficient ratio

% APD excess noise factor
F = kA * M + (1 - kA ) *(2 -1/ M ) ;

% APD signal current
signalAPD = M * R * P1 ;

% Noise for bit 0
sigma0APD = sqrt ( ...
2* q * M ^2* F * Id * B + thermalVar ) ;

% Noise for bit 1
sigma1APD = sqrt ( ...
2* q * M ^2* F *( R * P1 + Id ) * B + thermalVar ) ;

% Q - factor
QAPD = ...
signalAPD ./ ( sigma1APD + sigma0APD ) ;

% BER
BERAPD = ...
0.5 * erfc ( QAPD / sqrt (2) ) ;


%% =========================================================
% SNR CALCULATION
% ==========================================================
% Defined as :
% bit -1 signal - current squared / bit -1 noise variance
SNRPIN = ...
signalPIN .^2 ./ sigma1PIN .^2;
SNRAPD = ...
signalAPD .^2 ./ sigma1APD .^2;

%% =========================================================
% PLOT RESULTS
% ==========================================================
figure ( ’ Color ’ , ’w ’) ;

% % SNR
subplot (3 ,1 ,1) ;
plot ( P1dBm ,...
10* log10 ( SNRPIN ) ,...
’b ’ , ’ LineWidth ’ ,1.4) ;
hold on ;
plot ( P1dBm ,...
10* log10 ( SNRAPD ) ,...
’r ’ , ’ LineWidth ’ ,1.4) ;
ylabel ( ’ SNR_1 ( dB ) ’) ;
legend ( ’ PIN ’ , ’ APD ’) ;
title ( ’ SNR Comparison ’) ;
grid on ;

% % Q - factor
subplot (3 ,1 ,2) ;
plot ( P1dBm ,...
QPIN ,...
’b ’ , ’ LineWidth ’ ,1.4) ;
hold on ;
plot ( P1dBm ,...
QAPD ,...
’r ’ , ’ LineWidth ’ ,1.4) ;


ylabel ( ’Q - factor ’) ;
legend ( ’ PIN ’ , ’ APD ’) ;
title ( ’Q - factor Comparison ’) ;
grid on ;

% % BER
subplot (3 ,1 ,3) ;
semilogy ( P1dBm ,...
max ( BERPIN ,1 e -20) ,...
’b ’ , ’ LineWidth ’ ,1.4) ;
hold on ;
semilogy ( P1dBm ,...
max ( BERAPD ,1 e -20) ,...
’r ’ , ’ LineWidth ’ ,1.4) ;
xlabel ( ’ Received Bit -1 Optical Power ( dBm ) ’) ;
ylabel ( ’ BER ’) ;
legend ( ’ PIN ’ , ’ APD ’) ;
title ( ’ BER Comparison ’) ;
ylim ([1 e -12 1]) ;
grid on ;

%% =========================================================
% DISPLAY BASIC PARAMETERS
% ==========================================================
fprintf ( ’\ n ’) ;
fprintf ( ’ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = \ n ’) ;
fprintf ( ’ PIN AND APD RECEIVER RESULTS \ n ’) ;
fprintf ( ’ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = \ n ’) ;
fprintf ( ’ Wavelength
lambda *1 e9 ) ;

= %.0 f nm \ n ’ ,...

fprintf ( ’ Quantum efficiency
eta ) ;

= %.2 f \ n ’ ,...

fprintf ( ’ Responsivity
R);

= %.3 f A / W \ n ’ ,...

fprintf ( ’ Bandwidth
B /1 e9 ) ;

= %.2 f GHz \ n ’ ,...


fprintf ( ’ Temperature
T);

= %.0 f K \ n ’ ,...

fprintf ( ’ Load resistance
RL ) ;

= %.0 f Ohm \ n ’ ,...

fprintf ( ’ Dark current
Id ) ;

= %.2 e A \ n ’ ,...

fprintf ( ’\ n ’) ;
fprintf ( ’ APD multiplication gain
M);

= %.1 f \ n ’ ,...

fprintf ( ’ APD excess - noise factor
F);

= %.2 f \ n ’ ,...

%% =========================================================
% SENSITIVITY AT BER = 1e -9
% ==========================================================
targetBER = 1e -9;
idxPIN = find ( BERPIN <= targetBER ,1) ;
idxAPD = find ( BERAPD <= targetBER ,1) ;

fprintf ( ’\ n ’) ;
fprintf ( ’ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = \ n ’) ;
fprintf ( ’ RECEIVER SENSITIVITY \ n ’) ;
fprintf ( ’ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = \ n ’) ;
if ~ isempty ( idxPIN )
fprintf ( ’ PIN sensitivity at BER 1e -9 = %.1 f dBm \ n ’ ,...
P1dBm ( idxPIN ) ) ;
else
fprintf ( ’ PIN does not reach BER 1e -9 in the selected power range .\ n
’) ;
end
if ~ isempty ( idxAPD )
fprintf ( ’ APD sensitivity at BER 1e -9 = %.1 f dBm \ n ’ ,...
P1dBm ( idxAPD ) ) ;
else
fprintf ( ’ APD does not reach BER 1e -9 in the selected power range .\ n
’) ;
end
fprintf ( ’\ nSimulation completed successfully .\ n ’) ;