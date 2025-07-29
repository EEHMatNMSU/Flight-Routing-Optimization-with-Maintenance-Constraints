%Función que calcula el tiempo acumulado de la rotación y a su vez hace un
%ajuste de la rotación en caso de que esta no sea de ciclo cerrado
function [R,Rt,TA,LR]=RotTA1(T,Rt,R,E,D,nd,Lim,Escala)%recibe datos de vuelo(origen-destino),horarios, duración, Rotación, horarios de la rotación, turnaround y tiempo límite de la rotación

rc=0;
while (rc==0)
TiempoAcumulado=0;

LR=0;
Du=[];
Du1=[];
TA=[];

for n1=1:(size(R,1)-1)

   k=T(R(n1,3),Rt(n1,2));%tiempo de dura vuelo act
   Duracion=SumaTiempo(Rt(n1,1),k); %suma tiempo de salida
   Duracion=SumaTiempo(Duracion,Escala);
   k2=Duracion <Rt(n1+1,1);%compara llegada + turnaround

    if k2==1
        TiempoAcumulado=SumaTiempo(RestaTiempo(Rt(n1,1),Rt(n1+1,1)),TiempoAcumulado); %mismo dia
    else
        t1=SumaTiempo(RestaTiempo(Rt(n1,1),2400),Rt(n1+1,1));
        t2=TiempoAcumulado;
        TiempoAcumulado=SumaTiempo(t1,t2);%siguiente día
    end

    if TiempoAcumulado<=Lim; % realiza el corte de la rotación cuando el tiempo acumulado llega o se aproxima a timepo limite que se estableció para la rotación al comienzo
        Du1=[Du1;k2];
        TA=[TA;TiempoAcumulado];
        LR=n1+1;
    end

end
display(LR);
R=R(1:LR,:);
Rt=Rt(1:LR,:);

k=T(R(size(R,1),3),Rt(size(R,1),2));%timepo traslado ultimo vuelo
Duracion=SumaTiempo(Escala,k);
TF=SumaTiempo(TiempoAcumulado,Duracion);
TA=[TA;TF];
rc=1;
%corrección de rotaciones en caso de que no sean de ciclo cerrado
  if R(LR,2)~=R(1,1) %caso 1: Si el último destino coincide con el primer origen en caso contrario quita un vuelo
      R=R(1:(LR-1),:);
      Rt=Rt(1:(LR-1),:);
      if R(LR-1,2)~=R(1,1)%caso 2: si el último destino del nuevo R si es igual con el primer destino de R, si no ingresa
          in=1:size(E,1);% inices de los renglones de E
          in=in(E(:,1)==R(LR-1,2)&(E(:,2)==R(1,1)));%se busca cuales vuelos de E tienen el origen en el ultimo destino del nuevo R,y despues del & cuales vuelos de E tienen el destino en el primer origen de R
          if size(in,2)>0 %caso 3: si no cumple con ninguno de los casos anteriores, remueve más vuelos y reemplza hasta lograr el ciclo cerrado
              R=[R;[E(in,:),in]];
              i=in;
              P=D(i,1:size(D,2));
              P=P(~isnan(D(i,1:size(D,2))));
              ir=randi(numel(P));
              P1=P(ir);
              Rt=[Rt;[P1,ir]];
          else
              rc=0;
              disp('CASO COMPLEJO');
          end
      end
  end
end
 display (R);
 %entrga rotación, horarios de rotación y tiempo acumulado de la rotación
 end
