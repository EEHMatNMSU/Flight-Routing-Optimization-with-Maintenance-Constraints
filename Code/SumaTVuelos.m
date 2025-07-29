%Función que calcula el tiempo de vuelo de la rotación, el tiempo nuevo
%acumulado de la rotación  y tiempos de mantenimiento posterior a una permutación

function [Tvuelo,TAF,param]=SumaTVuelos(R,Rt,param)%recibe la nueva rotación (R), el nuevo Rt y los datos general de los vuelos (origen-destino,horarios,duraciones,turnaround)
R=param.R;
Rt=param.Rt;
T=param.T;
E=param.E;
D=param.D;
nd=param.nd;
Escala=param.Escala;
EAM=param.EAM;
TMLA=param.TMLA;
MaxNMtto=param.MaxNMtto;
param.RMtto=zeros(size(R,1),2);

Du=[];
Tvuelo=0;
Nmtto=1;
TV=[];
TANEW=[];
for n=1:size(R,1);%se realiza el cálculo del tiempo de vuelo de la rotación que contempla unicamente la duración
  k=T(R(n,3),Rt(n,2));
  Duracion=SumaTiempo(Rt(n,1),k);
  Duracion=SumaTiempo(Duracion,Escala);
  Du=[Du;Duracion];
  Duracion=RestaTiempo(Rt(n,1),Du(n));
  Duracion=RestaTiempo(Escala, Duracion);
  Tvuelo=SumaTiempo(Tvuelo,Duracion);
  TV=[TV;Tvuelo];
end

TiempoAcumulado=0;
%se realiza el cálculo del tiempo de vuelo acumulado de la rotación  y tiempos
% de mantenimiento que contempla duración y turnaround, y tiempos entre vuelos
% de un día a otro
for n1=1:(size(R,1)-1);
   k=T(R(n1,3),Rt(n1,2));%tiempo de dura vuelo actual
   Duracion=SumaTiempo(Rt(n1,1),k);   %suma tiempo de salida
   Duracion=SumaTiempo(Duracion,Escala);
   FinVuelo1=Duracion; %a que horas caba el primer vuelo
   if (EAM(R(n1+1,3),1)~=0 && Nmtto<(MaxNMtto+1))
     Duracion=SumaTiempo(Duracion,param.TMLA);
     param.RMtto(n1,2)=1;
     Nmtto= Nmtto+1;
   endif
   k2=Duracion <Rt(n1+1,1);%compara llegada + turnaround
   DuracionDia=Duracion; %a que hora acaba mantenimiento forzado o el vuelo+turnaround
    if k2==1
        param.RMtto(n1,1)=RestaTiempo(FinVuelo1,Rt(n1+1,1));%diferencia entre tiempo de salida + actual
        TiempoAcumulado=SumaTiempo(RestaTiempo(Rt(n1,1),Rt(n1+1,1)),TiempoAcumulado); %mismo dia
    else
        t1=SumaTiempo(RestaTiempo(Rt(n1,1),2400),Rt(n1+1,1));
        DuracionDia=RestaTiempo(2400,DuracionDia);%si al dia sig alcanza
        while DuracionDia > Rt(n1+1,1) %va a forzar pasar al dia siguiente
          t1=SumaTiempo(t1,2400);
          DuracionDia=RestaTiempo(2400,DuracionDia);
        endwhile
        t2=TiempoAcumulado;
        param.RMtto(n1,1)=RestaTiempo(SumaTiempo(k, Escala),t1);
        TiempoAcumulado=SumaTiempo(t1,t2);%siguiente día
    endif
    TANEW=[TANEW;TiempoAcumulado];
    if param.RMtto(n1,1)<param.TMLA || EAM(R(n1+1,3),1)==0
      param.RMtto(n1,1)=0;
     endif
endfor

k=T(R(size(R,1),3),Rt(size(R,1),2));%timepo traslado último vuelo
Duracion=SumaTiempo(Rt(size(R,1),1),k);   %suma tiempo de salida
Duracion=SumaTiempo(Duracion,Escala);
FinVuelo1=Duracion ;
   if (EAM(R(1,3),1)~=0 && Nmtto<(MaxNMtto+1))
     Duracion=SumaTiempo(Duracion,param.TMLA);
          Nmtto= Nmtto+1;
          param.RMtto(size(R,1),2)=1; %se mete en el R del priemero
   endif
k2=Duracion <Rt(1,1);%compara llegada + turnaround
DuracionDia=Duracion;
if k2==1
    param.RMtto(size(R,1),1)=RestaTiempo(FinVuelo1,Rt(1,1));
    TiempoAcumulado=SumaTiempo(RestaTiempo(Rt(size(R,1),1),Rt(1,1)),TiempoAcumulado); %mismo dia
else
    t1=SumaTiempo(RestaTiempo(Rt(size(R,1),1),2400),Rt(1,1));
    DuracionDia=RestaTiempo(2400,DuracionDia);%si al dia siguiente alcanza
        while DuracionDia > Rt(1,1) %va a forzar pasar al dia siguiente
          t1=SumaTiempo(t1,2400);
          DuracionDia=RestaTiempo(2400,DuracionDia);
        endwhile
    t2=TiempoAcumulado;
    param.RMtto(size(R,1),1)=RestaTiempo(SumaTiempo(k,Escala),t1);
    TiempoAcumulado=SumaTiempo(t1,t2);%siguiente día
end
if param.RMtto(size(R,1),1)<param.TMLA || EAM(R(1,3),1)==0 %cuando no se puede hacer el mantenimiento
      param.RMtto(size(R,1),1)=0;
     endif

TAF= TiempoAcumulado; %SumaTiempo(TiempoAcumulado,Duracion);
TANEW=[TANEW;TAF];

param.NumMtto=Nmtto-1;
param.TANEW=TANEW;
param.Du=Du;



%entrega tiempo de vuelo de la rotación y tiempo acumulado de la nueva
%rotación
param.R=R;
param.Rt=Rt;
end




