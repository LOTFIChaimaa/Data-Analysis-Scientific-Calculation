clear variables
close all
clc
%% Utilisation de l'ACP pour detecter plusieurs classes.

% Chargement du tableau de données.
load('dataset.mat')

% Calcul de la matrice de variance/covariance et détection des axes
% principaux.
 n = size(X,1);
 X_Moyenne = mean(X);
 X_Centree = X - X_Moyenne;
 sigma = (1/n) * (transpose(X_Centree)*X_Centree);
 [W,D] = eig(sigma);
 
%Reordonner les axes principaux.
[D_decroi,I] = sort(diag(D),'descend');
W = W(:, I);

%Afficher du pourcentage d'information apportée par chacune des composantes
%principales.
figure(1), 
plot(1: length(D_decroi),(D_decroi/sum(D_decroi)),'r*')
title('Pourcentage d info contenue sur chaque composante principale')
xlabel('num de la comp. ppale');
ylabel('pourcentage d info');

%Commentaire : On trouve que seulement 6 composantes principales sont
%nécessaires pour obtenir un taux d'information suffisant sur l'ensemble
%des données.

%Affichage des trois premiers axes principaux de X dans l'espace
C = X_Centree * W;
figure(2),
plot3(C(:,1),C(:,2),C(:,3),'b*');grid on
title('Proj. des donnees sur les 3 premiers axes ppaux')
%Commentaire : On constate qu'il y a 7 classes d'individus.

%Affichage des différentes classes de variables en couleurs différentes.
%(en utilisant kmeans)
id = kmeans(C(:,1:3),6);
figure(3),
for i = 1:6
    indix = find(id == i);
    plot3(C(indix,1),C(indix,2),C(indix,3),'*');grid on;hold on
end
title('Proj. des donnees sur les 3 premiers axes ppaux en utilisant kmeans')
legend('Classe 1','Classe 2','Classe 3','Classe 4','classe 5','Classe 6')
