clc
clear;
close all;
load('football.mat');

% A = cell2mat(img);
% A = reshape(A,[60000,784])/255;
% A = A(1:1000,:);

[X,y] = bkmeans(football_X,1,2);
gscatter(X(:,1),X(:,2),y);

%% BKmeans
function [X_tmp,y_tmp] = bkmeans(X,k,iter)
X_tmp = [];
for i = 1:k
    bestSSE = 9999999;
    bestLabel = [];
    for n = 1:iter
        [sse,label] = Kmeans(X,i);
        if sse < bestSSE
            bestSSE = sse;
            bestLabel = label;
        end
    end
    
%     X_tmp = sort([X bestLabel],size(X_tmp,2)+1);
    y_tmp = bestLabel;
    X_tmp = X;
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
        for i=1:2
            id = find(Y==i);
            C = X(id,:);
            m = mean(C,1);
            dis = abs(X-m);
            d = [d,sum(dis,2)];
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