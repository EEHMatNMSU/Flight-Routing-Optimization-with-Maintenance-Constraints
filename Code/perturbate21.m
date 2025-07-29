%Función cuya perturbación añade dos nuevos vuelos a la rotación junto con sus respectivos horarios
%en caso de no ser posible añadir vuelos, se da la posibilidad de ingresar a emplear otras perturbaciones.

function [Xc]=perturbate21(x2,param)%recibe la matriz de dos columnas (x0) y los datos general de los vuelos (origen-destino,horarios,duraciones,escala)

  if (rand()>0.1)% Si entra aqui NO agrega
    if (rand()>0.9)
      Xc=perturbate3(x2,param);
    else
      if (rand()>0.7)
        Xc=perturbate(x2,param);
      else
        if (rand()>0.5)
          Xc=perturbateHr(x2,param);
        else
          Xc=perturbate1(x2,param);
        endif
      endif
    endif
  else
    nrow=size(x2,1);
    ncol=size(x2,2);
  if nrow>2
    E=param.E;
    D=param.D;
    valido=0;
    it=0;
    xm=[];
    while (valido==0 && it<15)
      ix=randi(nrow-2,1)+1 ;% se escoge el indice/no cuenta el aeropueto origen y final de la rotación
      it=it+1;
      %VUELOS
      xc=x2;
      xm=xc;
      xx1=xc(ix-1,1);%busca en valor anterior al inidice seleccionado
      ee=1:size(E,1);
      ee=ee(E(:,1)==xc(ix-1,1));
      ee1=1:size(E,1);
      ee1=ee1(E(:,2)==xc(ix,1));
      posibles=[];
      for e=ee
        dest=E(e,2);
        ee2=1:size(E,1);
        ee2=ismember(E(:,1),dest);
        ee2=find(ee2)' ;
        for e1=ee2
           dest2=E(e1,2);
           ee3=1:size(E,1);
           ee3=ismember(E(:,1),dest2);
           ee3=find(ee3)' ;
           pos=ee3(E(ee3,2)==xc(ix,1));
           if ~isempty(pos)
              posibles=[posibles;[dest,dest2]];% dimensiones
           endif
         endfor
      endfor
      if size(posibles,2)>1
        c=posibles(randi(size(posibles,1)), :);
        xm=[xm([1:ix-1],:);[c(1,1),0];[c(1,2),0];xm([ix:end],:)]  ;
        valido=1;
      endif
      if valido==1
        eeh=1:size(E,1);
        eeh=eeh(E(:,1)==xm(ix-1,1)& E(:,2)==xm(ix,1));
        eeh1=1:size(E,1);
        eeh1=eeh1(E(:,1)==xm(ix,1)& E(:,2)==xm(ix+1,1));
        eeh2=1:size(E,1);
        eeh2=eeh2(E(:,1)==xm(ix+1,1)& E(:,2)==xm(ix+2,1));
        %validación del horario despúes de cambiar el vuelo
        P2=D(eeh,1:size(D,2));
        P2=P2(~isnan(D(eeh,1:size(D,2))));
        pn=randi(numel(P2));
        xm(ix-1,2)=pn;
        P3=D(eeh1,1:size(D,2));
        P3=P3(~isnan(D(eeh1,1:size(D,2))));
        pn1=randi(numel(P3));
        xm(ix,2) = pn1;
        P2=D(eeh2,1:size(D,2));
        P2=P2(~isnan(D(eeh2,1:size(D,2))));
        pn=randi(numel(P2));
        xm(ix+1,2)=pn ;
      endif
    endwhile
    if valido==1
      Xc=xm;
    else
      Xc=x2;
    endif
  else
    Xc=x2;
  endif
end

% entrega matriz con dos nuevos vuelos adicionados junto con sus respectivos horarios
end

