clear ;
clc ;
close all ;
rng (10) ;
%% =========================================================
% DIGITAL OPTICAL COMMUNICATION
% Line Coding + Bandwidth Effect + Eye Diagram
% ==========================================================
% % Basic Parameters
Nbits = 500;
sps = 64;
Rb = 1 e9 ;
Fs = Rb * sps ;

% Samples per bit ( must be even )
% Bit rate = 1 Gbps
% Sampling frequency

% % Generate Random Bits
bits = randi ([0 1] , 1 , Nbits ) ;
%% =========================================================
% PART 1: LINE CODING
% ==========================================================
% Unipolar NRZ
nrz = kron ( bits , ones (1 , sps ) ) ;
% 50% Return - to - Zero
rz = kron ( bits , ...
[ ones (1 , sps /2) , zeros (1 , sps /2) ]) ;
% Manchester coding
manchester = ...
kron ( bits , [ ones (1 , sps /2) , zeros (1 , sps /2) ]) + ...
kron (1 - bits , [ zeros (1 , sps /2) , ones (1 , sps /2) ]) ;
% % Show first 8 bits
nshow = 8 * sps ;
tshow = (0: nshow -1) / Fs * 1 e9 ;
waveforms = [ nrz ; rz ; manchester ];
names = { ’ Unipolar NRZ ’ , ’ 50% RZ ’ , ’ Manchester ’ };
% % Plot Line - Coded Waveforms
figure ( ’ Color ’ , ’w ’) ;
for k = 1:3
subplot (3 ,1 , k ) ;
stairs ( tshow , ...


waveforms (k ,1: nshow ) , ...
’ LineWidth ’ ,1.4) ;
xlabel ( ’ Time ( ns ) ’) ;
ylabel ( ’ Level ’) ;
title ( names { k }) ;
ylim ([ -0.2 1.2]) ;
grid on ;
end

%% =========================================================
% PART 2: ELECTRICAL CHANNEL BANDWIDTH
% ==========================================================
% Good bandwidth
fcGood = 0.8 * Rb ;
% Poor bandwidth
fcPoor = 0.2 * Rb ;
% First - order low - pass filter coefficients
aGood = exp ( -2* pi * fcGood / Fs ) ;
aPoor = exp ( -2* pi * fcPoor / Fs ) ;
% % Filter NRZ signal
yGood = filter ( ...
1 - aGood , ...
[1 - aGood ] , ...
nrz ) ;
yPoor = filter ( ...
1 - aPoor , ...
[1 - aPoor ] , ...
nrz ) ;

%% =========================================================
% PART 3: ADD RECEIVER NOISE
% ==========================================================
% Good channel : lower noise
yGood = yGood + ...
0.025 * randn ( size ( yGood ) ) ;
% Poor channel : higher noise
yPoor = yPoor + ...
0.070 * randn ( size ( yPoor ) ) ;

%% =========================================================


% PART 4: EYE DIAGRAM
% ==========================================================
% Two - bit time window
eyeTime = (0:2* sps -1) / sps ;
figure ( ’ Color ’ , ’w ’) ;

% % Good bandwidth eye
subplot (1 ,2 ,1) ;
hold on ;
for b = 20:200
idx = (b -1) * sps + (1:2* sps ) ;
plot ( eyeTime , ...
yGood ( idx ) , ...
’ LineWidth ’ ,0.5) ;
end
xlabel ( ’ Time / T_b ’) ;
ylabel ( ’ Normalized Voltage ’) ;
title ( ’ Wider Bandwidth , Lower Noise ’) ;
ylim ([ -0.3 1.3]) ;
grid on ;

% % Poor bandwidth eye
subplot (1 ,2 ,2) ;
hold on ;
for b = 20:200
idx = (b -1) * sps + (1:2* sps ) ;
plot ( eyeTime , ...
yPoor ( idx ) , ...
’ LineWidth ’ ,0.5) ;
end
xlabel ( ’ Time / T_b ’) ;
ylabel ( ’ Normalized Voltage ’) ;
title ( ’ Narrower Bandwidth , Higher Noise ’) ;
ylim ([ -0.3 1.3]) ;


grid on ;

%% =========================================================
% PART 5: DISPLAY PARAMETERS
% ==========================================================
fprintf ( ’\ n ’) ;
fprintf ( ’ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = \ n ’) ;
fprintf ( ’ DIGITAL OPTICAL COMMUNICATION SIMULATION \ n ’) ;
fprintf ( ’ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = \ n ’) ;
fprintf ( ’ Number of bits
fprintf ( ’ Bit rate
fprintf ( ’ Samples per bit
fprintf ( ’ Sampling frequency

=
=
=
=

% d \ n ’ , Nbits ) ;
%.2 f Gbps \ n ’ , Rb /1 e9 ) ;
% d \ n ’ , sps ) ;
%.2 f GHz \ n ’ , Fs /1 e9 ) ;

fprintf ( ’\ n ’) ;
fprintf ( ’ Good channel BW
fprintf ( ’ Poor channel BW

= %.2 f GHz \ n ’ , fcGood /1 e9 ) ;
= %.2 f GHz \ n ’ , fcPoor /1 e9 ) ;

fprintf ( ’\ nSimulation completed successfully .\ n ’) ;