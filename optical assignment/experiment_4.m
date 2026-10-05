clear ;
clc ;
close all ;
%% =========================================================
% OPTICAL COMMUNICATION LINK BUDGET
% Power Budget + Rise - Time Budget
% ==========================================================
% % PART 1: POWER BUDGET
% Transmitter power
Ptx = 0;

% dBm

% Receiver sensitivity
Psens = -24;

% dBm

% Required design margin
designMargin = 3;

% dB

% Fiber attenuation
alpha = 0.25;

% dB / km

% Fiber length
L = 50;

% km

% Connector parameters
Nc = 2;
Lc = 0.5;

% Number of connectors
% Loss per connector ( dB )

% Splice parameters
Ns = 10;
Ls = 0.1;

% Number of splices
% Loss per splice ( dB )

% % Calculate Fixed Loss


fixedLoss = Nc * Lc + Ns * Ls ;

% % Calculate Total Fiber Loss
fiberLoss = alpha * L ;

% % Calculate Total Passive Loss
totalLoss = fiberLoss + fixedLoss ;

% % Calculate Received Power
Prx = Ptx - totalLoss ;

% % Calculate Remaining Design Margin
remainingMargin = ...
Prx - Psens - designMargin ;

% % Maximum Power - Limited Fiber Length
LmaxPower = ...
( Ptx - Psens - designMargin - fixedLoss ) / alpha ;

%% =========================================================
% PART 2: RISE - TIME BUDGET
% ==========================================================
% Transmitter rise time
ttx = 120;

% ps

% Receiver rise time
trx = 150;

% ps

% Chromatic dispersion coefficient
D = 17;
% ps /( nm . km )
% RMS spectral width
sigmaLambda = 0.10;

% nm

% Modal rise time
% For single - mode fiber , modal dispersion is approximately zero
tmodal = 0;
% ps

% % Chromatic Dispersion Rise Time
tchrom = ...
2.563 * abs ( D ) * L * sigmaLambda ;

% % Total System Rise Time


tsys = sqrt ( ...
ttx ^2 + ...
trx ^2 + ...
tchrom ^2 + ...
tmodal ^2 ) ;

%% =========================================================
% PART 3: ALLOWED RISE TIME
% ==========================================================
% Target bit rate
Rb = 2.5 e9 ;

% bit / s

% NRZ rise - time criterion
allowedRise = ...
(0.7/ Rb ) * 1 e12 ;

% % Maximum NRZ Bit Rate
RbMax = ...
0.7 / ( tsys *1 e -12) ;

%% =========================================================
% DISPLAY RESULTS
% ==========================================================
fprintf ( ’\ n ’) ;
fprintf ( ’ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = \ n ’) ;
fprintf ( ’ OPTICAL COMMUNICATION LINK BUDGET RESULTS \ n ’) ;
fprintf ( ’ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = \ n ’) ;
fprintf ( ’\n - - - POWER BUDGET - - -\ n ’) ;
fprintf ( ’ Transmitter power
fprintf ( ’ Fiber loss
fprintf ( ’ Connector loss
fprintf ( ’ Splice loss
fprintf ( ’ Total passive loss
fprintf ( ’ Received power
fprintf ( ’ Receiver sensitivity
fprintf ( ’ Remaining design margin
fprintf ( ’ Power - limited length

=
=
=
=
=
=
=
=
=

%.2 f
%.2 f
%.2 f
%.2 f
%.2 f
%.2 f
%.2 f
%.2 f
%.2 f

dBm \ n ’ , Ptx ) ;
dB \ n ’ , fiberLoss ) ;
dB \ n ’ , Nc * Lc ) ;
dB \ n ’ , Ns * Ls ) ;
dB \ n ’ , totalLoss ) ;
dBm \ n ’ , Prx ) ;
dBm \ n ’ , Psens ) ;
dB \ n ’ , remainingMargin ) ;
km \ n ’ , LmaxPower ) ;

fprintf ( ’\n - - - RISE - TIME BUDGET - - -\ n ’) ;
fprintf ( ’ Transmitter rise time
fprintf ( ’ Receiver rise time
fprintf ( ’ Chromatic dispersion time
fprintf ( ’ Modal rise time
fprintf ( ’ System rise time

=
=
=
=
=

fprintf ( ’\ n ’) ;
fprintf ( ’ Target bit rate

= %.2 f Gb / s \ n ’ , Rb /1 e9 ) ;


%.2 f
%.2 f
%.2 f
%.2 f
%.2 f

ps \ n ’ ,
ps \ n ’ ,
ps \ n ’ ,
ps \ n ’ ,
ps \ n ’ ,

ttx ) ;
trx ) ;
tchrom ) ;
tmodal ) ;
tsys ) ;

fprintf ( ’ Allowed rise time
fprintf ( ’ Maximum NRZ bit rate

= %.2 f ps \ n ’ , allowedRise ) ;
= %.2 f Gb / s \ n ’ , RbMax /1 e9 ) ;

%% =========================================================
% LINK FEASIBILITY CHECK
% =========================================================
fprintf ( ’\n - - - LINK CHECK - - -\ n ’) ;
if remainingMargin >= 0
fprintf ( ’ Power budget : PASS \ n ’) ;
else
fprintf ( ’ Power budget : FAIL \ n ’) ;
end
if tsys <= allowedRise
fprintf ( ’ Rise - time budget : PASS \ n ’) ;
else
fprintf ( ’ Rise - time budget : FAIL \ n ’) ;
end
fprintf ( ’\ nSimulation completed successfully .\ n ’) ;