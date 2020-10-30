function [idx,C,sumD,D] = MyKmeans(X,K,C0,numIter)


sumDist(numIter) = 0;

for n = 1:numIter;
    
        dist = X*C0';
        [del, identX] = max(dist'); 
        XLabel = [X, identX'];
       
    for i = 1:K
        temp = (XLabel(:, size(XLabel,2)) == i);
        C0(i,:) = mean(XLabel(temp,1:size(XLabel,2)-1));
    end

sumDist(n) = sum(dist(:));
identx(n,:) = XLabel(:,size(XLabel,2));

end

D = dist;
C = C0;
sumD = sumDist;
idx = identx;




                
                
        

    
        
