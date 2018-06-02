clc
clear;
close all;
load('iris.mat');
load('wine.mat');
load('ff.mat');

X = Iris;
B = unique(X,'rows');
X = table2array(B(:,1:4));
y = table2array(B(:,5));
X = X.*100;

X2 = wine;
B = unique(X2,'rows');
X2 = table2array(B(1:end-1,2:14));
y2 = table2array(B(1:end-1,1));
X2 = X2.*100;

X3 = forestfires1;
B = unique(X3,'rows');
X3 = table2array(B(1:end-1,2:11));
y3 = table2array(B(1:end-1,1));
X3 = X3.*100;

Y = randi([1,1000],size(X,1), 2);
[coeff,score,latent] = pca(X);
Y2 = [score(:,1) score(:,2)];
Y3 = tsne(X);

YY = randi([1,1000],size(X2,1), 2);
[coeff2,score2,latent2] = pca(X2);
YY2 = [score2(:,1) score2(:,2)];
YY3 = tsne(X2);

YYY = randi([1,1000],size(X3,1), 2);
[coeff3,score3,latent3] = pca(X3);
YYY2 = [score3(:,1) score3(:,2)];
YYY3 = tsne(X3);

c = lines(3);
c2 = lines(3);
c3 = lines(9);

norm = a4.sammon(X,Y,2000,0.00001,0.1);
wpca = a4.sammon(X,Y2,2000,0.00001,0.1);
wtsne = a4.sammon(X,Y3,2000,0.00001,0.1);
norm2 = a4.sammon(X2,YY,2000,0.00001,0.1);
wpca2 = a4.sammon(X2,YY2,2000,0.00001,0.1);
wtsne2 = a4.sammon(X2,YY3,2000,0.00001,0.1);
norm3 = a4.sammon(X3,YYY,2000,0.00001,0.1);
wpca3 = a4.sammon(X3,YYY2,2000,0.00001,0.1);
wtsne3 = a4.sammon(X3,YYY3,2000,0.00001,0.1);

subplot(3,3,1); 
gscatter(norm(:,1),norm(:,2),y,c);
subplot(3,3,2);
gscatter(wpca(:,1),wpca(:,2),y,c);
subplot(3,3,3);
gscatter(wtsne(:,1),wtsne(:,2),y,c);
subplot(3,3,4); 
gscatter(norm2(:,1),norm2(:,2),y2,c);
subplot(3,3,5);
gscatter(wpca2(:,1),wpca2(:,2),y2,c);
subplot(3,3,6);
gscatter(wtsne2(:,1),wtsne2(:,2),y2,c);
subplot(3,3,7); 
gscatter(norm3(:,1),norm3(:,2),y3,c);
subplot(3,3,8);
gscatter(wpca3(:,1),wpca3(:,2),y3,c);
subplot(3,3,9);
gscatter(wtsne3(:,1),wtsne3(:,2),y3,c);