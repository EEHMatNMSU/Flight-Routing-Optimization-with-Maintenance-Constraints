%Función que calcula una rotación completa empleando el algorimo de reocido simulado
%Recibe:Datos de vuelo (origen-destino. horarios y duración), tiempo que debe durar la rotación en días, tiempo de tunraround
% y cantidad de mantenimientos necesarios
%Entrega: Una rotación que incluye el resultado de la función objetivo, matriz xx (origen-destino y horaios), cantidad de mantenimeintos y tiempo de mantenimientos.


pkg load io
pkg load statistics

[E,D,T,NumDia,Escala,AM,TMLA,MaxNMtto,RMtto]=General(7,30,1,1,'../DATOS_EXCEL/vuelosc1.xlsx','../DATOS_EXCEL/horariosc1.xlsx','../DATOS_EXCEL/duracionc1.xlsx')% se ingrasan datos (tiempo a calcular la rotación, tiempo de turnaround, aeropuerto de mantenimiento, cantidad de mantenimientos, vuelos excel, horarios excel y duración excel)
farch=fopen('NOMBRE_ARCHIVO.txt','w')% nombra el archivo donde se imprimirá los resultados


for i=1:15 %cantidad de pruebas o iteraciones que desean ser realizadas por el algoritmo
[nd,Lim,R,Rt,Du,TA,LR,EAM]=Rotaciones(E,D,T,NumDia,Escala,AM);

param.E=E;
param.D=D;
param.T=T;
param.NumDia=NumDia;
param.Escala=Escala;
param.nd=nd;
param.TMLA=TMLA;
param.AM=AM;
param.EAM=EAM;
param.Lim=Lim
param.MaxNMtto=MaxNMtto;
param.R=R;
param.Rt=Rt;
param.Du=Du;
param.TA=TA;
param.LR=LR;
param.NumMtto=0;
param.RMtto=RMtto;

x0=XX(R,param);

[xbest,fbest,param]=simann2(@fnumfl,@perturbate21,x0,param,1,1,-1, 10,20, 50,0.95,'',1000)% datos de algoritmo:
%ingresa; simann2(función objetivo, perturbación, x0, param, verb,MaxOMin,T0, Nt,Ns, maxfcount,rT,fileN,printingFreq)
%entrega:xbest,fbest
printxbest=sprintf('%d ',reshape(xbest,1,[])); %formatos de impresion
fprintf( farch,'%f %d %s \n \n',fbest,param.NumMtto,printxbest)%formatos de impresion
fprintf(farch,'%d %d \n' , param.RMtto'); %formatos de impresion
fprintf(farch,'\n \n' ); %formatos de impresion
fflush(farch)%va imprimiendo a medida que va acabando cada prueba

end
fclose(farch)








