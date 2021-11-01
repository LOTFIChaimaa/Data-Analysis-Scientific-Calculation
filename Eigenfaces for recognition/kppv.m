%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP4 - Reconnaissance de chiffres manuscrits par k plus proches voisins
% fonction kppv.m
%--------------------------------------------------------------------------
function [Partition,distance_min,MatConfusion,indices,var] = kppv(DataA,DataT,labelA,K,ListeClass,labelT)
    [Na,~] = size(DataA);
    [Nt,~] = size(DataT);

    Partition = zeros(Nt,1);
    % Initialisation du vecteur d'étiquetage des images tests
    disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
    disp(['par la methode des ' num2str(K) ' plus proches voisins:'])
    
    Nc =length(ListeClass);
for i = 1 : Nt
    
        % Calcul des distances entre les vecteurs de test 
        % et les vecteurs d'apprentissage (voisins)
        
        distances = zeros(Na,1);
        for j = 1:Na
            distances(j) = norm(DataA(j,:)-DataT(i,:));      
        end

        % On ne garde que les indices des K + proches voisins
        
        [~,index]= sort(distances,'ascend');
        indices = index(1:K); % indices des K + proches voisins
        var=index(1);
        distance_min = distances(index(1));
        
        % Comptage du nombre de voisins appartenant à chaque classe
        
        classevoisins = labelA(indices); % La classe de chacun des K + proches voisins 
       
        nombresvoisins = histc(classevoisins,ListeClass);
        
        % Recherche de la classe contenant le maximum de voisins
        [classemax,indice_max] = max(nombresvoisins);

        % Si l'image test a le plus grand nombre de voisins dans plusieurs  
        % classes différentes, alors on lui assigne celle du voisin le + proche,
        % sinon on lui assigne l'unique classe contenant le plus de voisins 

        indice = find(nombresvoisins == classemax);
        if length(indice) == 1
            classemax = ListeClass(indice_max);
        else
            classemax = labelA(indices(1));
        end
        
        % Assignation de l'étiquette correspondant à la classe trouvée au point 
        % correspondant à la i-ème image test dans le vecteur "Partition" 

      Partition(i) = classemax;
      
 end

   MatConfusion = zeros(Nc,Nc);

  nb = 0;
   for i=1:Nc
       for j=1:Nc
           for k=1:Nt
               if (labelT(k) == i) && (Partition(k) == j)
                   nb = nb+1;
               end
           end
          MatConfusion(i,j) = nb;
          nb=0;
       end
   end

end






