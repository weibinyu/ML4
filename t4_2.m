clc
clear;
close all;
load('dataFeature.mat');
X = table2array(features);
mat = sammon(X,1,1,1);

function sam = sammon(X,iter,e,a)
    limit = size(X,2);
    for i = 1:iter
        r = randi([1 limit],1,2);
        Y = [X(:,r(1)) X(:,r(2))];
        sam = cost(X,Y);
        %%
    end
end
function cos = cost(X,Y)
    out_sum = 0;
    in_sum = 0;
    n = 2;
    Y = sum(Y,2);
    X = sum(X,2);
    in_sum = sum(X,1);
    for i = 1:size(X,1)
        for ii = n:size(X,1)
            out_sum = out_sum + ((Y(i) - X(i))^2)/X(i);
        end
        n=n+1;
    end
    cos= (1/in_sum)*out_sum;
end