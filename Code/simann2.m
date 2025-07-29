%Algoritmo para maximizacion: MaxOMin=1, para minimizacion: MaxOMin=-1

function[xbest,fbest,param]=simann2(f,perturbation,x0,param,verb,MaxOMin,T0, Nt,Ns, maxfcount,rT,fileN,printingFreq)

R=param.R;
Rt=param.Rt;
T=param.T;
E=param.E;
D=param.D;
nd=param.nd;
Escala=param.Escala;

it=0;
if fileN~=''
fileID=fopen(fileN,'w');
endif
nrow=size(x0,1);
ncol=size(x0,2);
    %verb
    if (Nt==-1)
      Nt=5*nrow*ncol;
    end
    xt=x0; %Configuracion de trabajo
    n=nrow*ncol;
    fxt=f(xt,param); %Evalua la primera configuracion
    xbest=x0; %En xbest se almacena la mejor configuracion conocida
    fbest=fxt;%En fbest se almacena el mejor valor de funcion
    fbestA=fbest;
    if (verb==1)
      display(fbest)
    end
    stop=false;
    aver=fxt;
    naver=1;
    fcount=0;
    if(T0==-1)
      T=Inf;
    end
    %%
    %xbet=[];
    %fbet=[];
    while (~stop)
    paver=0.0;
    nprob=0;
    xt=xbest;
    fxt=fbest;
        for t=1:Nt
          for c=1:Ns
            for np=1:n
              %display([fcount t c np])
              xpert=perturbation(xt,param);
              fpert=f(xpert,param);
              printxpert=sprintf('%d ',reshape(xpert,1,[]));
              printxbest=sprintf('%d ',reshape(xbest,1,[]));
              if (mod(it,printingFreq)==0)
                display([num2str(it) " " num2str(fpert) " " num2str(T) " " num2str(printxpert)]);%debe imprimir it, fpert,y todos los valores del xpert
                display([num2str(it) " " num2str(fbest) " " num2str(T) " " num2str(printxbest)]);
              endif
              if fileN~=''
                fprintf(fileID,'%d %d %f %f %s ',fcount, it, fpert, T, printxpert);
                fprintf(fileID, '\n');
                fprintf(fileID,'%d %d %f %f %s ',fcount, it, fbest, T, printxbest);
                fprintf(fileID, '\n');
              endif
              it=it+1;
              aver=abs(aver)+abs(fpert);
              naver=naver+1;
              if ((MaxOMin*-1.0*fpert)<(MaxOMin*-1.0*fbest))
                fbest=fpert;
                xbest=xpert;
              end
              Deltaf=(MaxOMin*-1.0*fpert)-(MaxOMin*-1.0*fxt);
              prob=exp(-Deltaf/T);
              if(Deltaf>0)
                paver=paver+prob;
                nprob=nprob+1;
              end
              if (Deltaf<=0 || prob>rand(1))
                xt=xpert;
                fxt=fpert;
              end
            end
          end
          if (T==Inf)
            T=rT*aver/naver
          end
        end
        T=rT*T;
        if (verb==1)
          display(T)
          probaverage=paver/nprob;
          display(paver)
          display(nprob)
          display(probaverage);
          display(fbest)
          display(fbestA)
        end
        if ( ((MaxOMin*-1.0*fbest))==(MaxOMin*-1.0*fbestA) )
          fcount=fcount+1
        else
          if (fcount>=maxfcount || probaverage<0.5)
            T=T*1.0/rT^2;
          end
          fcount=0;
        end
        fbestA=fbest;
        if (fcount>=maxfcount || probaverage<(1.0/(4*n)))
          stop=true;
        end
    end
    if fileN~=''
    fclose(fileID);
    endif
    [fbest,param]=f(xbest,param)
end

