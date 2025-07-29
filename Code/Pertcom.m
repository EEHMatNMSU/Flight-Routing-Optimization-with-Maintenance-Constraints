function [Xc]=Pertcom(x2,param)%recibe la matriz que contiene el origen de cada vuelo y el horario para realizar una perturbación que combina
 %dos perturbaciones

[XN]=perturbate1(x2,param);
[Xc]=perturbate3(XN,param);

end
