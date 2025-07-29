%Función que calcula todas las opciones posibles de de vuelos en una rotación

function [R]=RotR1(E,nd)% recibe datos de vuelo (origen-destino)

R=[];
Et=E;
for i=1:nd;
a=randi(size(Et,1));
randomRow = [Et(a,:),find(ismember(E, Et(a,:),'rows')) ];
R=[R ; randomRow]; %almacena los vuelos seleccionados
Vp=Et(a,2);
RowIdx = find(ismember(E(:,1), Vp,'rows'));
Et=E(RowIdx,:);
end
%entrega rotación con vuelos que indican origen-destino,y el índice al que
%pertenece cada vuelo
end
