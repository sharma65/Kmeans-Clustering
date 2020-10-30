function TestMyKmeans(filename,numRepeat, numIter)
data = importdata(filename);
Y = data(:,1)+1; X = data(:,2:end); clear data;
K = max(Y); n = length(Y);

%%%%%%
%%% Normalize the data to have unit L2 norm
%%%%

for j = 1:n
    X(j,:) = X(j,:)./norm(X(j,:));
    norm(X(j,:));
end

SD1 = zeros(numRepeat,numIter);
for i = 1:numRepeat;
C0 = X(randsample(n,K),:);
tic;[idx1{i},C1,SD1(i,:),D1{i}]=MyKmeans(X,K,C0,numIter); T1(i) = toc;
tic;[idx2{i},C2,sumd2,D2{i}]=kmeans(full(X),K,'Start',full(C0),'Maxiter',numIter);
T2(i)=toc;
SD2(i,:) = sum(sumd2);
for t = 1:numIter;
    acc1(i,t) = evalClust_Error(idx1{i}(t,:),Y);
end

acc2(1, i) = evalClust_Error(idx2{i}(:,1),Y);


output = [acc1(1:i,end) acc2(1:i)' SD1(1:i,end) SD2(1:i) T1(1:i)' T2(1:i)'];
feval('save',[filename '.summary.txt'],'output','-ascii');
end

figure;
plot(1:numIter,SD1,'linewidth',1);hold on; grid on;
xlabel('Iteration');ylabel('SD');
title(filename);

figure;
plot(1:numIter, acc1, 'linewidth',1); hold on; grid on;
avgCurve = sum(acc1)/numRepeat;
plot(1:numIter, avgCurve, 'b--', 'linewidth',1);
set(gca,'FontSize', 20);
xlabel('Iteration'); ylabel('Accuracy(%)');
title(filename);

figure;
q = plot(1:numRepeat, T1, 'linewidth',3); hold on; grid on;
w = plot(1:numRepeat, T2, 'linewidth',3); 
M1 = 'My Time on each repeat';
M2 = 'Matlab Time on each repeat';
legend([q,w], M1, M2);
set(gca,'FontSize', 20);
xlabel('Repeat Number'); ylabel('Time');
title(filename);

end