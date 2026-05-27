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
library(blockCV); library(dismo); library(gbm); library(ncf) ;
```

### 2. La localisation de l'étude : #Zone d'étude est l'Europe : EU = shapefile("") grâce au fichier : 
![texte](https://github.com/roxy232/Epidemiologie_Rapport1/blob/main/Photo/HAutomne.png "Europe HAutomne")
### 3. Les fichiers d'entrée sont dans le dossier Raster_environnement afin d'avoir tous les variables environnementals séléctionnées. 

```
#Etape 1 : définir les variables de l'environmentale a été :''
envVariableNames = c("croplands_all_categories","human_pop_density_log10","managed_pasture_and_rangeland","Precipitation_inFall",
"Precipitation_spring","Precipitation_summer","Precipitation_winter","primary_forest_areas","primary_non_forest_areas","relative_Humidity_inFall","relative_Humidity_spring","relative_Humidity_summer","relative_Humidity_winter","secondary_forest_areas","secondary_non_forest_areas","temperature_inFall","temperature_spring","temperature_summer","temperature_winter")
envVariables = list() #On crée une liste 'envVariables' qui contient chaques couches
for (i in 1:length(envVariableNames)) {
  fileName = paste0(",".asc")         #à compléter 
  envVariables[[i]] = raster(fileName, overwrite=T)
  names(envVariables[[i]]) = envVariableNames[i]
}
```
#Cartes des variables d'environnements
Output : différentes cartes de l'Europe en fonction des variables environnementales 

#Etape 4 : ANALYSE DE L'AUTOCORRÉLATION SPATIALE (CORRÉLOGRAMMES)
Output : ![texte](https://github.com/roxy232/Epidemiologie_Rapport1/blob/main/Photo/Correlation4000.png)

#Etape 5 : Entrainement des models de niche écologique (Chaque nouvel arbre essaie de corriger les erreurs de l'arbre précédent => optimiser) 
```
theRanges=c(2100,2100)*1000 
```
Il faut adapter le chiffre 2100 si cela n'est pas la valeur limite du corrélogramme. 
#VALIDATION CROISEE
#ANALYSE :
```
AUCs=matrix(nrow=number_of_replicates,ncol=1) #vérifie si le résultat du modèle final est fiable/robuste
colnames(AUCs)=c("AUC") #doit être plus proche de 1
```
On détermine si la robustesse des arbres avec AUC. 

#Etape 6 : Cartographie de risque :  
Output: carte de risque ![texte](https://github.com/roxy232/Epidemiologie_Rapport1/blob/main/Photo/risque_virus.png)
#7PREMIERs REPLICATs EXEMPLE : VISUALISATION 
#CALCUL DE LA VARIABILITÉ (INCERTITUDE)  forcer le min à 0 et max à 1 : 
![texte](https://github.com/roxy232/Epidemiologie_Rapport1/blob/main/Photo/Capture%20d'%C3%A9cran%202026-05-15%20110921.png)

#Etape 8 : les importances relatives du virus en fonction des variables de l'environnment : RI 
et l'étape 9 est la visialisation de la niche écologique avec RI 
Output : Visualisation DE RI
![texte](https://github.com/roxy232/Epidemiologie_Rapport1/blob/main/Photo/ETAPE9.png "Niche") 
