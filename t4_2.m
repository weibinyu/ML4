clc
clear;
close all;
load('iris.mat');
 X = Iris;
 B = unique(X,'rows');
 X = table2array(B(:,1:4));
 y = table2array(B(:,5));

 
Y = randi([1,1000],size(X,1), 2);
mat = sammon(X,Y,4000,0.00001,0.1);
scatter(mat(:,1),mat(:,2));

function Y = sammon(X, Y, iter, e, a)   
    disX = disM(X);
    disY = disM(Y);
    C = sum(disX(:))/2;
    cost = stress(disY,disX,C);
    for i = 1:iter
        if cost>e
            delta = findD(Y, disY, disX,C);
            Y = Y + a.* delta;
            disY = disM(Y);
            cost= stress(disY,disX,C);
        end
    end
end

function dis = disM(X)
 dis =zeros(size(X,1),size(X,1)); 
    for i =1:size(X,1)
        dis(i,:) = sqrt(sum(abs((X(i,:)-X)).^2,2));
    end
end

function cost = stress(disY,disX,C)
    t=(disY-disX).^2./disX;
    cost = sum(t(~isnan(t)))/(2*C);
end

function delta = findD(Y, disY, disX,C)
    n=size(disX,1);
    f=[0 0]; 
    s=[0 0];
    delta=zeros(n,2);
    for i=1:n
        id=setdiff(1:n,i);
        dis=Y-Y(i,:);
        dis=dis(id,:);
        d=disY(id,i);
        D=disX(id,i);
        t=(D-d)./(d.*D);
        f=f+(-2/C)*sum(t.*dis );
        s=s+(-2/C)*sum(  ((D-d)-(dis.^2)./d.*(1.+t)) ./(D.*d));
        delta(i,:)=f./s;
    end

end