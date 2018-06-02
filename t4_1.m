clc
clear;
close all;
load('Iris.mat');
X = table2array(Iris(:,1:4));
Y = table2array(Iris(:,5));
res = bkmeans(X,2,10);
gscatter(res(:,1),res(:,2),res(:,end));

%% BKmeans
function res = bkmeans(X,k,iter)
res = [X zeros(size(X,1),1)];
positions = [1 size(X,1)];
for i = 1:k
    bestSSE = 9999999;
    bestLabel = [];
    for n = 1:iter
        [sse,label] = Kmeans(res(positions(1):positions(2),:),i*2);
        if sse < bestSSE
            bestSSE = sse;
            bestLabel = label;
        end
    end
    y_tmp = bestLabel;
    res(positions(1):positions(2),size(res,2)) = y_tmp;
    res = sortrows(res,size(res,2));
    positions = pickC(res);
end
end

%% K-means
function [sse,label] = Kmeans(X,c)
    a=floor((size(X,1)/2));
    Y = zeros(size(X,1),1);
    Y(1:floor((size(X,1)/2))) = c;
    Y(floor((size(X,1)/2)+1):end) = c+1;
    Y = Y(randperm(size(Y,1)),:);
    oldSSE = 1000000;
    newSSE = 999999;
    
    while oldSSE > newSSE
        oldSSE = newSSE;
        d = [];
        n=c;
        for i=1:2
            id = find(Y==n);
            C = X(id,:);
            m = mean(C,1);
            dis = abs(X-m);
            d = [d,sum(dis,2)];
            n=n+1;
        end
        for n = 1:size(d,1)
            if d(n,1) < d(n,2)
                Y(n) = c;
            else
                Y(n) = c+1;
            end
        end
        newSSE = SSE(X,Y);
    end
    label = Y;
    sse = newSSE;
end
%% SSE
function sse = SSE(X,y)
sse=0;
    for i=1:2
        total=0;
        id=find(y==i);
        C=X(id,:);
        m=mean(C,1);
        dis=abs(C-m);
        for n=1:size(dis,2)
            total = total + dis(:,n).^2;
        end
        sse=sse+sum(total);
    end
end
function pos = pickC(X)
Y=X(:,size(X,2));
uni = unique(Y);
biggestC = 0;
pos = 0;
start = 1;
stop = 0;
for i = 1:size(uni,1)
    n = sum(X(:,size(X,2)) == uni(i));
    stop = stop + n;
    if biggestC < n
        biggestC = n;
        pos = [start stop];
    end
    start = start + stop;
end
end