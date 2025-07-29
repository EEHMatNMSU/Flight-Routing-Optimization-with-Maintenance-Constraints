%Función que recibe y lee los datos de entrada en formtato .xlsx de los vuelos existentes con sus
%respectivos horarios y tiempos de duración

function [E,D,T,NumDia,Escala,AM,TMLA,MaxNMtto,RMtto]=General(NumDia,Escala,AM,MaxNMtto,E1,D1,T1)%recibe número de días, tiempo de turnaround, aeropuerto base de mantenimiento, archivos de vuelos para la rotación
TMLA=800;%tiempo min de mantenimento aeronave en cientos o miles

if nargin==0
NumDia=input ('Numero de dias');
Escala=input ('Tiempo escala');
AM=input ('Aeropuerto de Mantenimiento');

MaxNMtto=size(AM,1);

RMtto=[];% lleva la cantidad y tiempos de mantenimento

%lectura archivos de datos de vuelo que contienen origen y destino
[file,path] = uigetfile('*.xlsx');
E1=fullfile(path,file);
E=xlsread(E1);

%lectura archivos de datos de vuelo que contienen horarios de los vuelos
[file,path] = uigetfile('*.xlsx');
D1=fullfile(path,file);
D=xlsread(D1);

%lectura archivos de datos de vuelo que contienen duraciones de los vuelos
[file,path] = uigetfile('*.xlsx');
T1=fullfile(path,file);
T=xlsread(T1);
else

E=xlsread(E1);

D=xlsread(D1);

T=xlsread(T1);
%entrga datos de vuelos en matrices

RMtto=[];

end
end
