%Función que calcula la rotación y el tiempo para el cual se limita la
%rotación
function [nd,Lim,R,Rt,Du,TA,LR,EAM]=Rotaciones(E,D,T,NumDia,Escala,AM)%recibe datos iniciales de vuelos(origen-destino),horarios, duraciones, número de días, turnaround y aeropuerto base de mantenimiento

%cálculo del tiempo en horas de la rotación
Lim=NumDia*2400;
m1=nanmean(T);
mT=mean(m1);
nd=((Lim)/(mT+Escala));
EAM=E;
for i=1:size(AM,1)
EAM(EAM~=AM(i))=0;
end


%cálculo de la rotación, horarios de los vuelos de la rotación, tiempo
%acumulado de la rotación y duración de la rotación
TiempoAcumulado=0;
R=RotR1(E,nd);
Rt=RotRt1(D,R,E,T,nd);
[R,Rt,TA,LR]=RotTA1(T,Rt,R,E,D,nd,Lim,Escala);
Du=RotDu1(R,Rt,T,E,D,nd,Escala);

end
