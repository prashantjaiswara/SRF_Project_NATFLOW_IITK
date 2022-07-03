clc
clear all
close all

amp=[ 10, 15, 20 ]; % Pitching amplitude in degrees
F = [1,2,3,4];      % Pitching Frequency in Hz
S = 6;              % Image acquisition frequency in Hz


t0= ( acos(amp/amp) )./ (2*pi.*F);
del_t = 1/S;

theta=zeros( 10, length(amp), length(F) );

for F=1:1:4    
    for i=1:1:10
        theta(i,:,F) = amp*cos(  (2*pi*F*( (i-1)*del_t)) );
    end
end
