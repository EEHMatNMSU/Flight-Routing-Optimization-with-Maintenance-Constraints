%Función que convierte el resultado de la rotación a dos columnas en la
%cual la primera columna indica el origen de cada vuelo y la segunda
%columna indica el horario de cada vuelo 

function [X2]=XX(R,param)% Recibe la rotación y los datos general de los vuelos (origen-destino,horarios,duraciones,escala)


R=param.R;
Rt=param.Rt;
T=param.T;
E=param.E;
D=param.D;
nd=param.nd;
Escala=param.Escala;

APT = [R(:,1)];%extrae la primera coluna de R
HA =[ Rt(:,2)];%extrae la segunda columna de Rt
X2=[APT HA];% Se crea una matriz con las dos columnas extraidas

end