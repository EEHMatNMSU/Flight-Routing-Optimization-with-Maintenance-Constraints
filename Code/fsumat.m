%Función objetivo donde calcula el tiempo de vuelo de la rotación y el
%tiempo acumulado total de la rotación

function [fobj,param]=fsumat(Xc,param)%recibe la matriz que contiene el origen de cada vuelo y el horario
%seleccionado que le corresponde
Lim=param.Lim;

[R2,Rt,param]=RR(Xc,param);% Convierte la matriz de dos columnas a tres como en el R inical
[fobj,TAF,param]=SumaTVuelos(R2,Rt,param);%Realiza la sumatoria del tiempo de vuelo, el tiempo de vuelo acumulado de la rotación y los tiempos de mantenimeinto

 if (TAF>Lim || param.NumMtto<param.MaxNMtto)
     fobj=Lim-fobj;%el tiempo total es mayor que el limite, por tanto se resta
   else
     fobj=fobj+Lim;
 end

 fobj=fobj+Lim; %dos veces el timepo limite más el tiempo real

end
