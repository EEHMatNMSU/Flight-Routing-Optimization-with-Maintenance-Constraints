%Función que calcula la duración de cada vuelo teniendo en cuenta el tiempo
%de turnaround y la hora de salida

function [Du]=RotDu1(R,Rt,T,E,D,nd,Escala)%recibe las rotaciones, horarios, vuelos, tiempos de vuelos, duración de vuelos y turnaround

Du=[];

for n=1:size(R,1)
k=T(R(n,3),Rt(n,2));%busca el renglón y horario del vuelo seleccionado para conocer su respectiva duración
Duracion=SumaTiempo(Rt(n,1),k);%realiza la sumatoria del horario y la duración del vuelo
Duracion=SumaTiempo(Duracion,Escala);%sumatoria de la duración total anterior y turnaround
Du=[Du;Duracion];% almacena la sumatoria total de cada vuelo
end

end

