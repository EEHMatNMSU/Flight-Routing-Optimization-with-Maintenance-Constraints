%Función objetivo donde calcula cantidad de vuelos

function [fobj,param]=fnumfl(Xc,param)%recibe la matriz que contiene el origen de cada vuelo y el horario
%seleccionada que le corresponde
Lim=param.Lim;

[R2,Rt,param]=RR(Xc,param);% Convierte la matriz de dos columnas a tres como en el R inical
[fobj,TAF,param]=SumaTVuelos2(R2,Rt,param);%Realiza la sumatoria del tiempo de vuelo, el tiempo de vuelo acumulado de la rotación y tiempos de mantenimiento
fobj=(size(R2,1)+1)*Lim;
 if (TAF>Lim || param.NumMtto<param.MaxNMtto)
     fobj=3*Lim-TAF;
 else
     fobj=fobj+Lim;
 end

 fobj=fobj+Lim;

end
