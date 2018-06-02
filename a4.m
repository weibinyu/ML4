classdef a4 % Same name as .m file
    properties % Not in use
    end
    methods(Static)
        function clear()
            clear; % Clear Command Window
            close all; % Close all figure windows
            clc % Clear Workspace
        end
        function Y = sammon(disX, Y, iter, e, a)
        disX = a4.disM(disX);
        disY = a4.disM(Y);
        C = sum(disX(:))/2;
        cost = a4.stress(disY,disX,C);
        for i = 1:iter
            if cost>e
                delta = a4.findD(Y, disY, disX,C);
                Y = Y + a.* delta;
                disY = a4.disM(Y);
                cost= a4.stress(disY,disX,C);
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
    end
        
       
end