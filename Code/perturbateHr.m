%Función donde se perturban horario de un vuelo
function [Xper]=perturbateHr(x2,param)%recibe la matriz de dos columnas (X0) y los datos general de los vuelos (origen-destino,horarios,duraciones,escala)
  nrow=size(x2,1);
  ncol=size(x2,2);
  Xper=x2;
  if nrow>2
    E=param.E;
    D=param.D;
    valido=0;
    ix=randi(nrow,1);% se escoge el indice; no cuenta el aeropueto origen y final de la rotación
    en=1:size(E,1);
    if (ix<nrow)
      en=en( E(:,1)==Xper(ix,1) &(E(:,2)==Xper(ix+1,1))); %Indice del horario del vuelo del ix al ix+1
    else
      en=en( E(:,1)==Xper(ix,1) &(E(:,2)==Xper(1,1)));
    endif
    P2=D(en,1:size(D,2)); %Horarios del vuelo seleccionado
    P2=P2(~isnan(D(en,1:size(D,2)))); %Elimina los nan del arreglo de horarios
    pn=randi(numel(P2)); %Selecciona algun horario de manera aleatoria
    Xper(ix,2)=pn; %Asigna el horario seleccionado
  endif
end


