%Función que convierte el resultado de la perturbación de nuevo a un R de
%tres columnas

function [RR2,Rt,param]=RR(x,param)%recibe la rotación perturbada y los datos general de los vuelos (origen-destino,horarios,duraciones,turnaround)
nrow=size(x,1);
ncol=size(x,2);

    R=param.R;
    Rt=param.Rt;
    T=param.T;
    E=param.E;
    D=param.D;

    RR2=[];
    Eg=E;
    Rt=[];
    for m=1:(size(x,1)-1);% se reliza la formación de los detinos que acompañan a cada vuelo
        ig=x(m,1);
        ij=x(m+1,1);
        eb=1:size(Eg,1);
        eb=eb(Eg(:,1)==ig &(Eg(:,2)==ij));
        rRow = [Eg(eb,:),find(ismember(E, Eg(eb,:),'rows'))];
        RR2=[RR2;rRow] ;% almacena los vuelos origen-destino, junto con el indice correspondiente a su horario
        i= rRow(3);%se realiza de nuevo el cálculo de los horarios de cada vuelo
        P=D(i,1:size(D,2));% selecciona la franja de horarios correspondiente al cada vuelo
        P=P(~isnan(D(i,1:size(D,2))));
        ir=x(m,2);
        P1=P(ir);
        Rt=[Rt;[P1,ir]];  % almacena los horaarios, junto con el indice de horario de las diferentes opciones de horario que presenta
    end
    eb=1:size(Eg,1);%se realiza la formación del destino que acompaña el último vuelo
    eb=eb((Eg(:,2)==x(1,1))& Eg(:,1)==x(size(x,1),1));
    rRown = [Eg(eb,:),find(ismember(E, Eg(eb,:),'rows'))];
    RR2=[RR2;rRown]; % almacena el último vuelo origen-destino, junto con el indice correspondiente a su horario

    i= rRown(3);%se realiza de nuevo el cálculo del horario del último vuelo
        P=D(i,1:size(D,2));% selecciona la franja de horarios correspondiente al ultimo vuelo
        P=P(~isnan(D(i,1:size(D,2))));
        ir=x(size(x,1),2);
        P1=P(ir);
        Rt=[Rt;[P1,ir]]; % almacena el ultimo horario, junto con el indice de horario de las diferentes opciones de horario que presenta

        param.R=RR2;
        param.Rt=Rt;

  %endif

end
