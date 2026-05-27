# Rapport1 : Niche écologique et Cartographie de risque d'un arbovirus en Europe 

Vous verez ici, les fichiers utilisées pour réaliser nos analyses. Nous allons utiliser R_studio et appliquer le modèle de BRT. 

### Introduction : 
Les arbovirus représentent une menace pour la santé publique en Europe en raison de son introduction possible 
faisant des ravages en Asie par exemple. La transmission vectorielle d’un virus se fait par des arthropodes hématophages tels que les moustiques. Leur distribution est liée aux conditions environnementales favorables au vecteur. La modélisation de la niche écologique constitue un outil pour prédire et cartographier les zones à risque de transmission virale.  
L’étude s’appuie sur la technique de cross-validation couplée avec l’algorithme Boosted Regression Trees (BRT). 
Cette approche permet de relier les variations environnementales à la présence documentée du virus tout en 
limitant les biais liés à l’autocorrélation spatiale des données d’occurrence.  
L’objectif principal est d’identifier les variables environnementales influençant la propagation d’un arbovirus 
(via les importances relatives, RI) et de produire une carte de risque de présence à l’échelle européenne. 

## Mise en place du code et des résultats (https://www.swisstransfer.com/d/1489b24d-927a-43a7-aa8f-789ab24005da) 
Le fichier Rapport1_arbovirusEurope.R réalise toutes les étapes.

### 1. Utilisation de packages : 
```library(raster); library(sf); library(sp); library(RColorBrewer)
library(blockCV); library(dismo); library(gbm); library(ncf) ;```

### 2. La localisation de l'étude : #Zone d'étude est l'Europe : ```EU = shapefile("")``` grâce au fichier : 

### 3. Les fichiers d'entrée sont dans le dossier Raster_environnement afin d'avoir tous les variables environnementals séléctionnées. 
```
Etape 1 : définir les variables de l'environmentale a été :''
envVariableNames = c("croplands_all_categories","human_pop_density_log10","managed_pasture_and_rangeland","Precipitation_inFall",
"Precipitation_spring","Precipitation_summer","Precipitation_winter","primary_forest_areas","primary_non_forest_areas","relative_Humidity_inFall","relative_Humidity_spring","relative_Humidity_summer","relative_Humidity_winter","secondary_forest_areas","secondary_non_forest_areas","temperature_inFall","temperature_spring","temperature_summer","temperature_winter")
envVariables = list() #On crée une liste 'envVariables' qui contient chaques couches
for (i in 1:length(envVariableNames)) {
  fileName = paste0(",".asc")         #à compléter 
  envVariables[[i]] = raster(fileName, overwrite=T)
  names(envVariables[[i]]) = envVariableNames[i]
}
```
### Cartes des variables d'environnements

<img width="1165" height="712" alt="COMPARAISON_EX" src="https://github.com/user-attachments/assets/7b663f49-a0f2-4f62-a88c-272e26c50e0b" />

Outputs : AUC, Relative importances, BRT_model_replicates et prediction, CV for incertitude 
and 3 figures 




