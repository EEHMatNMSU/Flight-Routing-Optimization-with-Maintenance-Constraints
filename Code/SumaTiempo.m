%Funcion de suma t1 y t2, y regresa la diferencia en minutos,18:45->1845
function ttime = SumaTiempo(t1,t2)
    ttime=(floor(t1/100)*60+(t1-floor(t1/100)*100))+(floor(t2/100)*60+(t2-floor(t2/100)*100));
    ttime=floor(ttime/60)*100+(ttime-floor(ttime/60)*60);
end
   