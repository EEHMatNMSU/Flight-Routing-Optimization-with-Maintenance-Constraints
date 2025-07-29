%Funcion de resta t2-t1 y regresa la diferencia en minutos,18:45->1845
function Tmin = RestaTiempo(t1,t2);
    Tmin = (floor(t2/100)*60+(t2-floor(t2/100)*100))-(floor(t1/100)*60+(t1-floor(t1/100)*100));
    Tmin=floor(Tmin/60)*100+(Tmin-floor(Tmin/60)*60);
end
