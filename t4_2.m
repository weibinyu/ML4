clc
clear;
close all;
load('dataFeature.mat');
X = table2array(features);
mat = sammon(X,5000,100,1);

function sam = sammon(X,iter,e,a)
    bestCost = 9999999;
    limit = size(X,2);
    X_sum = sum(X,2);
    %% keneng yaogai
    in_sum = sum(X_sum,1);
    for i = 1:iter
        r = randi([1 limit],1,2);
        while r(1)==r(2)
            r = randi([1 limit],1,2);
        end
        Y = [X(:,r(1)) X(:,r(2))];
        currentCost = cost(X,Y,in_sum);
        if currentCost < bestCost
            bestCost = currentCost;
            bestY = Y;
        end
        if e<bestCost
            i = iter;
        end
    end
    
    o = one(X_sum,Y,in_sum);
    sam = bestCost;
end

function o = one(X_sum,Y,in_sum)
    for i = 1:size(X_sum,1)
        for ii = n:size(X_sum,1)
            out_sum = out_sum + (X_sum(i)-Y(i))/X_sum(i);
        end
        n=n+1;
    end
    o = -2;
end

function cos = cost(X,Y,in_sum)
    out_sum = 0;
    n = 2;
    for i = 1:size(X,1)
        for ii = n:size(X,1)
            d = (Y(i,:)-Y(ii,:));
            d = d.^2;
            d = sum(d,2);
            d= sqrt(d);
            b= (X(i,:)-X(ii,:));
            b=b.^2;
            b= sum(b,2);
            d=sqrt(d);
            out_sum = out_sum + ((d - b)^2)/ b;
        end
        n=n+1;
    end
    cos= (1/in_sum)*out_sum;
end