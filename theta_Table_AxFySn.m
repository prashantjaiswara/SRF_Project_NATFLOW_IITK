clc
clear all
close all

amp = [ 10, 15, 20 ]; % Pitching amplitude in degrees
F   = [1,2,3,4];      % Pitching Frequency in Hz
S   = 6;              % Image acquisition frequency in Hz


t0      = ( acos(amp/amp) )./ (2*pi.*F);
del_t   = 1/S;

theta   = num2cell(zeros( 10, length(amp) + 1, length(F) ) );

for F=1:1:4
    theta(1,:,F)= { strcat("Timestep(S:", string(S),"Hz)"), strcat('A10F',string(F)), strcat('A15F',string(F)), strcat('A20F',string(F)) };
    
    for i=2:1:10
        theta(i,1,F)     = num2cell( 0 + (i-2)*del_t);
        theta(i,2:end,F) = num2cell( amp*cos(  (2*pi*F*( (i-2)*del_t)) ) );
    end
    
end
