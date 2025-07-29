%Función donde se perturban dos vuelos de la rotación incluyendo sus respectivos horarios de vuelo

function [Xper]=perturbate(x2,param)%recibe la matriz de dos columnas (x0) y los datos general de los vuelos (origen-destino,horarios,duraciones,escala)
  nrow=size(x2,1);
  ncol=size(x2,2);
    if nrow>2
  E=param.E;
  D=param.D;
  valido=0;
  it=0;
  xn=[];
while (valido==0 && it<15)
  ix=randi(nrow-2,1)+1;% se escoge el indice; no cuenta el aeropueto origen y final de la rotación
  it=it+1;
%VUELOS
  per=x2;
  xn=per;
  xx=per(ix-1,1);%busca en valor anterior al inidice selec
  ee=1:size(E,1);
  ee=ee(E(:,1)==per(ix-1,1));% que vuelos aplican en esa selecc

 if size(ee,2)>1 ;
     ED=ee(randi(size(ee,2)));
     c=E(ED,:);% se escoge el vuelo

     if c(1,2)~=per(ix,1); %si el seleccionado es diferente al actual
         %c(1,2)~=per(ix,1);
         xn(ix,1)=[E(ED,2)]; %reemplazo del nuevo en el actual
         en=1:size(E,1);
         en=en( E(:,1)==xn(ix,1) &(E(:,2)==xn(ix+1,1)));
         if en>=1
               valido=1;
         else
               valido=0;
         end
     end
 end
if valido==1
 %validación del horario despúes de cambiar el vuelo
                P2=D(en,1:size(D,2));
                P2=P2(~isnan(D(en,1:size(D,2))));
                pn=randi(numel(P2));
                xn(ix,2)=pn;
                P2=D(ED,1:size(D,2));
                P2=P2(~isnan(D(ED,1:size(D,2))));
                pn=randi(numel(P2));
                xn(ix-1,2)=pn;
end
end
      if valido==1
        Xper=xn;
      else
        Xper=x2;
      end

  else
    Xper=x2;
   end


% entrega matriz con dos vuelos y sus respectivos horarios modificados
end




