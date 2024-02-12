clear all
clc

%***parameters***
Ma= 600 ;%Input torque Nm %~60 kgm
nh= 25  ;%housing roller number %24:1 ratio for drive
%for 1050 steel cold-drawn
Sut = 690     ;%Mpa
SutN= 690*10^6;%N/m^2
Sy  = 580     ;%Mpa
SyN = 580*10^6;%N/m^2
%**
e= 1.8           ;%assumpiton %mm
em= 0.002        ;%m
D= 100           ;%mm %since D/2nh>=e
Dm= 0.1          ;%m
Pmax= Ma/em      ;%max force between housing rollers and disk with simplification
A= pi()*(Dm^2)/4 ;%m^2 %as simplification
sigma= Pmax/(2*A);%N/m^2 %sigma m = sigma a
%******

%***calculating Se***
a= 4.51     ;%surface finish factor
b= -0.265   ;%surface finish exponent
ka= a*Sut^b ;%surface factor

if D < 51
    kb=1.24*D^-0.107;
else 
    kb=1.51*D^-0.157;
end

kc=1; %only bending assumed
kd=1; %assumption
kf=1;
ke=0.814 ; % 0.99 reliability
Se0 = 345;
Se=ka*kb*kc*kd*kf*ke*Se0 ;%Mpa
SeN=Se*10^6              ;%N/m^2
%******

%***mgoodman failure criterion***
Nf=1/((sigma/SeN)+(sigma/SutN));
fprintf('safety factor of fatigue : %f \n\n',Nf);
%******

%**design parameters**
dr=D/nh ;%mm
fprintf('eccentricity: %f \npitch radius of housing rollers: %f \nhousing rollers diameter: %f \n',e,D,dr);

db=dr*(nh-1) ;%base circle diameter %mm
na=8         ;%first assumption for output roller number
da=(db-4)/na ;%diameters of holes for output rollers %mm
do=da-(2*e)  ;%output roller diameter %mm
fprintf('base circle diameter: %f \ndiameters of holes for output rollers: %f \noutput roller number: %f \noutput roller diameter: %f\n\n\n',db,da,na,do);
%****
