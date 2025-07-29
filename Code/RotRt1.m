%Función que calcula el horario correspondiente de salida de cada uno de
%los vuelos establecidos en la rotación

function [Rt]=RotRt1(D,R,E,T,nd)%recibe datos iniciales de vuelos(origen-destino),horarios, duraciones y R

Rt=[];
%sleecciona un horario para cada vuelo de la Rotación creada
for m=1:nd
    i= R(m,3);%selecciona el vuelo y toma su índice
    P=D(i,1:size(D,2));%con el índice busca a que fila de horarios pertenece el vuelo
    P=P(~isnan(D(i,1:size(D,2))));%se elimina las casillas que no tengan horario
    ir=randi(numel(P));% se escoje de manera aleatoria uno de los horarios
    P1=P(ir);
    Rt=[Rt;[P1,ir]];%se almacena los horarios que se van seleccionando para cada vuelo
end

end
