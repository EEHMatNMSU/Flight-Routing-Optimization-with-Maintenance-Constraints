%Función que cuya perturbación elimina una determinada cantidad de vuelos y
%a su vez añade nuevos vuelos incluyendo sus respectivos horarios

function [Xc]=perturbate3(x2,param)%recibe la matriz de dos columnas (x0) y los datos general de los vuelos (origen-destino,horarios,duraciones,escala)
  nrow=size(x2,1);
  ncol=size(x2,2);
  valido=0;
  if nrow>2
    E=param.E;
    D=param.D;
    it=0;
    xm=[];
    while (valido==0 && it<15)
      ix=0;
      ix2=0;
      while ix==ix2
        ix=randi(nrow-2,1)+1 ;% se escoge el indice, no cuenta el aeropueto origen y final de la rotación
        ix2=randi(nrow-2,1)+1 ;
        if ix>ix2
          ixt=ix;
          ix=ix2;
          ix2=ixt;
        endif %end if
      endwhile %end if
      it=it+1;
      %VUELOS
      xc=x2;
      xm=xc;
      ee=1:size(E,1);
      ee=ee(E(:,1)==xc(ix-1,1));
      ee1=1:size(E,1);
      ee1=ee1(E(:,2)==xc(ix2+1,1));
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
          pos=ee3(E(ee3,2)==xc(ix2+1,1));
          if ~isempty(pos)
            posibles=[posibles;[dest,dest2]];% dimensiones
          endif
        endfor
      endfor
      if size(posibles,2)>1
        c=posibles(randi(size(posibles,1)), :);
        xm=[xm([1:ix-1],:);[c(1,1),0];[c(1,2),0];xm([ix2+1:end],:)] ;
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
        xm(ix+1,2)=pn;
      endif
    endwhile
    Xc=xm;
  else
      Xc=x2;
  endif
% entrega matriz con vuelos removidos y nuevos vuelos adicionados junto con sus respectivos horarios
  if valido==0
    XN=x2;
  endif

end
