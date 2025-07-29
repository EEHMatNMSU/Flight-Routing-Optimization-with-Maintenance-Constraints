function [X]=nanmean(M)
    if (size(M,1)==1 || size(M,2)==1)
        X=mean(M(!isnan(M)));
    else
        for i=1:size(M,2)
            X(i)=mean( M( !isnan(M(:,i)),i) );
        end
    end
end    
