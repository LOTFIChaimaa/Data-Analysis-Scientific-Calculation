clear;
close all;
load donnees_bis;
load exercice_1bis;


% Pourcentage d'information 
per = 0.95;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres] :

% Nombre de composantes principale nécessaire pour atteindre le pourcentage
% d'information

N = 1;
pourcentage_atteint = 0;
trace_sigma = sum(V_triees);

while pourcentage_atteint < per*trace_sigma
    pourcentage_atteint = pourcentage_atteint + V_triees(N);
    N=N+1;
end
    
% N premieres composantes principales des images d'apprentissage :

Comp = individu_centre*W(:,1:N);

%% Configuration du classifieur et Matrice de Confusion

K = 1;
labelA = repmat(numeros_individus, nb_postures, 1);
labelA = labelA(:);

labelT = repmat(numeros_individus, 6, 1);
labelT = labelT(:);
ListeClass = numeros_individus;

% N premieres composantes principales des images de test :
 Nc = 37; % Nombre de classes
 DataT = zeros(n,p);
 nombre_postures = 6;
 for i=0:Nc-1
     for j=1:nombre_postures
         chemin = './Images_Projet_2020';
         fichier = [chemin '/' num2str(i+4) '-' num2str(j) '.jpg'];
         Im=importdata(fichier);
         I=rgb2gray(Im);
         I=im2double(I);
         image_test=I(:)';
         DataT(nombre_postures*i+j,:) = image_test;
     end 
 end
% 
% % % N premieres composantes principales des images de test :

 Data_test_centre =  DataT - ones(37*6,1)*individu_moyen;
 
 Data_test = Data_test_centre*W(:,1:N);
 
 [Partition,distance_min,MatConfusion,indices] = kppv(Comp,Data_test,labelA,K,ListeClass,labelT);
 

 %% Taux d'erreur
 taux_erreur = 0;
 
for i=1:Nc
    for j=1:Nc
        if i~=j && MatConfusion(i,j)~=0
            taux_erreur = taux_erreur+1;
        end
    end
end
taux_erreur = taux_erreur/(6*Nc);
%taux_erreur=taux_erreur*100;
fprintf("Le taux d'erreur est donné par : %.2d\n",taux_erreur);

 
