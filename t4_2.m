clc
clear;
close all;
load('dataFeature.mat');
X = table2array(features(1:200,:));
mat = sammon(X,1000,100,1);

function sam = sammon(X,iter,e,a)
    bestCost = 9999999;
    limit = size(X,2);
    bestY=[];
    for i = 1:iter
        r = randi([1 limit],1,2);
        while r(1)==r(2)
            r = randi([1 limit],1,2);
        end
        Y = [X(:,r(1)) X(:,r(2))];
        currentCost = cost(X,Y);
        if currentCost < bestCost
            bestCost = currentCost;
            bestY = Y;
        end
        if e<bestCost
          	 break
        end
    end
    
    o = one(X,bestY);
    t = two(X,bestY);
    tri = o/t;
    sam = bestCost;
end

function t = two(X,Y)
    in_sum = 0;
    out_sum = 0;
    for i = 1:size(X,1)
        for ii = 1:size(X,1)
            if i ~= ii
                d = (Y(i,:)-Y(ii,:));
                d = d.^2;
                d = sqrt(sum(d,2));
                b= (X(i,:)-X(ii,:));
                b=b.^2;
                b=sqrt(sum(b,2));
                out2 = (1/(b-d))*((b-d)-(((Y(i,:)-Y(ii,:)).^2)/d)*...
                    (1+((b-d)/d)));
                out_sum = out_sum + out2;
                in_sum = in_sum+b;
            end
        end
    end
    t = (-2/in_sum)*out_sum;
end

function o = one(X,Y)
    out_sum = 0;
    in_sum =0;
    for i = 1:size(X,1)
        for ii = 1:size(X,1)
            if i ~= ii
                d = (Y(i,:)-Y(ii,:));
                d = d.^2;
                d = sqrt(sum(d,2));
                b= (X(i,:)-X(ii,:));
                b=b.^2;
                b=sqrt(sum(b,2));
                out1 = ((b-d)/(b*d))*(Y(i,:)-Y(ii,:));
                out_sum = out_sum + out1;
                in_sum = in_sum+b;
            end
        end
    end
    o = (-2/in_sum)*out_sum;
end

function cos = cost(X,Y)
    out_sum = 0;
    in_sum = 0;
    n = 2;
    for i = 1:size(X,1)
        for ii = n:size(X,1)
            d = (Y(i,:)-Y(ii,:));
            d = d.^2;
            d= sqrt(sum(d,2));
            b= (X(i,:)-X(ii,:));
            b=b.^2;
            b=sqrt(sum(b,2));
            out_sum = out_sum + (((d - b)^2)/ b);
            in_sum = in_sum+b;
        end
        n=n+1;
    end
    cos= (1/in_sum)*out_sum;
end