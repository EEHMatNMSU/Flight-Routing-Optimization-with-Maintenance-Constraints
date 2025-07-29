%Función donde se perturba un horario de la rotación
function [Xper]=perturbate1(x2,param)%recibe la matriz de dos columnas (X0) y los datos general de los vuelos (origen-destino,horarios,duraciones,escala)
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

    if (rand()>0.8) %selección hacia adelante o atrás de la franja del horario
      if (Xper(ix,2)==size(P2)(2))
        pn=1;
      else
        pn=Xper(ix,2)+1;
      endif
      else
        if (Xper(ix,2)==1)
          pn=size(P2)(2);
        else
          pn=Xper(ix,2)-1;
        endif
    endif

    Xper(ix,2)=pn; %Asigna el horario seleccionado dentro de la matriz
  endif
end


