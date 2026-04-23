#--------------NICHE ECOLOGIQUE de notre virus------------------------

# Les différents packages qu'on va utiliser :
if (!require(raster)) install.packages("raster")
if (!require(sf)) install.packages("sf")
if (!require(sp)) install.packages("sp")
if (!require(RColorBrewer)) install.packages("RColorBrewer")
if (!require(blockCV)) install.packages("blockCV")
if (!require(dismo)) install.packages("dismo")
if (!require(gbm)) install.packages("gbm")
if (!require(gbm)) install.packages("ncf")
library(raster); library(sf); library(sp); library(RColorBrewer)
library(blockCV); library(dismo); library(gbm); library(ncf) ; 

#Zone d'étude est l'Europe :
EU = shapefile("C:/Users/hoste/OneDrive - Université Libre de Bruxelles/Documents/Cours/VIRUS/Tdegrp/1.GIS_cartog_risq/Coasts_study_area_shapefile/Coasts_study_area_shapefile/Coasts_study_area_shapefile.shp")
#faut mettre le lien du fichier donnée 

# Etape 1 : définir les variables de l'environmentale a été : 
envVariableNames = c("croplands_all_categories","human_pop_density_log10","managed_pasture_and_rangeland","Precipitation_inFall",
                     "Precipitation_spring","Precipitation_summer","Precipitation_winter","primary_forest_areas","primary_non_forest_areas","relative_Humidity_inFall","relative_Humidity_spring",
                     "relative_Humidity_summer","relative_Humidity_winter","secondary_forest_areas","secondary_non_forest_areas","temperature_inFall","temperature_spring","temperature_summer","temperature_winter")
envVariables = list() #On crée une liste 'envVariables' qui contient chaques couches
for (i in 1:length(envVariableNames)) {
  fileName = paste0("C:/Users/hoste/OneDrive - Université Libre de Bruxelles/Documents/Cours/VIRUS/Tdegrp/1.GIS_cartog_risq/Environmental_raster_files/Environmental_raster_files/Raster_",envVariableNames[i],".asc")
  envVariables[[i]] = raster(fileName, overwrite=T)
  names(envVariables[[i]]) = envVariableNames[i]
}

#Illustration des variables d'environnements :
par(mfrow=c(1,7), oma=c(0,0,1.5,0), mar=c(0.75,0,0,0), lwd=0.2,  col="gray30", col.axis="gray30", fg="gray30") #on figuration de la fenêtre graphique
cols = colorRampPalette(brewer.pal(9,"YlOrRd"))(150)[1:100] #Couleur
#TEMPERATURE
plot(envVariables[[16]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5) #CONTOUR
mtext("Température Automne", side=3, line=1, cex=0.7, col="gray30") #titre
mtext("(°C)", side=3, line=0.3, cex=0.67, col="gray30")
plot(envVariables[[16]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3, 
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T) #la légende 

plot(envVariables[[17]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5) #CONTOUR
mtext("Température Printemps", side=3, line=1, cex=0.65, col="gray30") #titre
mtext(" (°C)", side=3, line=0.4, cex=0.65, col="gray30")
plot(envVariables[[17]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3, 
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T) 

plot(envVariables[[18]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5) #CONTOUR
mtext("Température été", side=3, line=1, cex=0.65, col="gray30") #titre
mtext("(°C)", side=3, line=0.5, cex=0.65, col="gray30")
plot(envVariables[[18]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3, 
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T) 

plot(envVariables[[19]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5) #CONTOUR
mtext("Température Hiver", side=3, line=1, cex=0.65, col="gray30") #titre
mtext("(°C)", side=3, line=0.5, cex=0.65, col="gray30")
plot(envVariables[[19]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3, 
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T) 

#Précipitations :
cols = colorRampPalette(brewer.pal(9,"YlGnBu"))(100)
plot(envVariables[[4]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("Précipitation en Automne", side=3, line=1, cex=0.65, col="gray30")
mtext(expression("(kg/m"^2*"/day)"), side=3, line=0.2, cex=0.65, col="gray30")
plot(envVariables[[4]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)

plot(envVariables[[5]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("Précipitation au Printemps", side=3, line=1, cex=0.65, col="gray30")
mtext(expression("(kg/m"^2*"/day)"), side=3, line=0.2, cex=0.65, col="gray30")
plot(envVariables[[5]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)

plot(envVariables[[6]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("Précipitation en Eté", side=3, line=1, cex=0.65, col="gray30")
mtext(expression("(kg/m"^2*"/day)"), side=3, line=0.2, cex=0.65, col="gray30")
plot(envVariables[[6]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)

plot(envVariables[[7]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("Précipitation en Hiver", side=3, line=1, cex=0.65, col="gray30")
mtext(expression("(kg/m"^2*"/day)"), side=3, line=0.2, cex=0.65, col="gray30")
plot(envVariables[[7]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)

#L'Humidité : 
cols = colorRampPalette(brewer.pal(9,"YlGnBu"))(100)
plot(envVariables[[10]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("L'Humidité en Automne", side=3, line=1, cex=0.65, col="gray30")
mtext(expression("(kg/m"^2*"/day)"), side=3, line=0.2, cex=0.65, col="gray30")
plot(envVariables[[10]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)

plot(envVariables[[11]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("L'Humidité au Printemps", side=3, line=1, cex=0.65, col="gray30")
mtext(expression("(kg/m"^2*"/day)"), side=3, line=0.2, cex=0.65, col="gray30")
plot(envVariables[[11]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)

plot(envVariables[[12]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("L'Humidité en Eté", side=3, line=1, cex=0.65, col="gray30")
mtext(expression("(kg/m"^2*"/day)"), side=3, line=0.2, cex=0.65, col="gray30")
plot(envVariables[[12]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)


plot(envVariables[[13]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("L'Humidité en Hiver", side=3, line=1, cex=0.65, col="gray30")
mtext(expression("(kg/m"^2*"/day)"), side=3, line=0.2, cex=0.65, col="gray30")
plot(envVariables[[13]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)

#fORêTs (les primaires sont les plus vielles n'ayant pas été affecté par l'activité humaine, l'échelle est le pourcentage de forêt 1er/pixel)
cols = colorRampPalette(c("gray97","chartreuse4"),bias=1)(100)
plot(envVariables[[8]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("Forêts", side=3, line=1, cex=0.65, col="gray30")
mtext("Primaire", side=3, line=0.5, cex=0.65, col="gray30")
plot(envVariables[[8]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)

cols = colorRampPalette(c("gray97","chartreuse4"),bias=1)(100)
plot(envVariables[[15]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("Forêts", side=3, line=1, cex=0.65, col="gray30")
mtext("Secondaire", side=3, line=0.5, cex=0.65, col="gray30")
plot(envVariables[[15]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)

#Non-forestière 1er (naturels qui n'ont jamais été transformé mais montre les espaces sauvages sans arbres.)
plot(envVariables[[9]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("Non-Forestière", side=3, line=1, cex=0.65, col="gray30")
mtext("Primaire", side=3, line=0.3, cex=0.65, col="gray30")
plot(envVariables[[9]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)


cols = colorRampPalette(c("gray97","olivedrab3"),bias=1)(100)
plot(envVariables[[14]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("NON-Forestière", side=3, line=1, cex=0.65, col="gray30")
mtext("Secondaire", side=3, line=0.3, cex=0.65, col="gray30")
plot(envVariables[[14]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)

#Croplands
cols = colorRampPalette(c("gray97","navajowhite4"),bias=1)(100)
plot(envVariables[[1]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("Terres Agricoles", side=3, line=1, cex=0.65, col="gray30")
mtext("(Toutes catégories)", side=3, line=0.4, cex=0.65, col="gray30")
plot(envVariables[[1]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)

#pastures 
cols = colorRampPalette(c("gray97","burlywood3"),bias=1)(100)
plot(envVariables[[3]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("Pastures", side=3, line=1, cex=0.65, col="gray30")
mtext("and rangeland", side=3, line=0.5, cex=0.65, col="gray30")
plot(envVariables[[3]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)

#HUMAINs : 
cols = colorRampPalette(brewer.pal(9,"BuPu"))(150)[1:100]
plot(envVariables[[2]], col=cols, ann=F, legend=F, axes=F, box=F)
plot(EU, add=T, border="gray50", lwd=0.5)
mtext("Humain", side=3, line=1, cex=0.65, col="gray30")
mtext(expression("population (log"[10]*")"), side=3, line=0.3, cex=0.65, col="gray30")
plot(envVariables[[2]], col=cols, legend.only=T, add=T, legend.width=0.5, legend.shrink=0.3,
     smallplot=c(0.10,0.80,0.09,0.12), adj=3, axis.args=list(cex.axis=0.7, lwd=0, lwd.tick=0.2,
                                                             col.tick="gray30", tck=-0.9, col="gray30", col.axis="gray30", line=0, mgp=c(0,0.1,0)),
     alpha=1, side=3, horizontal=T)


#Etape 2 : Données du virus, Présences : 
records_Arbovirus = read.csv("C:/Users/hoste/OneDrive - Université Libre de Bruxelles/Documents/Cours/VIRUS/Tdegrp/Binome_06/Arbovirus_risk_mapping_simulated_dataset_2-2.CSV", head=T)[,c("longitude","latitude")]
template = envVariables[[1]]; template[!is.na(template[])] = 1 
cells_Arbovirus = unique(raster::extract(template, records_Arbovirus, cellnumbers=T))[,"cells"] #On identifie exactement dans quelles "cases" (pixels) du raster se trouve le virus.
background = template #part du raster modèle pour générer les autres en arrière
#background[!(1:length(background[]))%in%cells_Arbovirus] = NA # toutes les cellules sans occurrence deviennent NA (inconnues).
cells_background = which(!is.na(background[]))
number_of_replicates = 50 # nombre de répétition pour stabiliser les résultats statistique 
dataframes = list() 
# On crée un raster vide (NA) basé sur le template, puis on marque "1" là où le virus est présent
presence_raster = template
presence_raster[] = NA  
presence_raster[cells_Arbovirus] = 1

#Etape 3 : Boucle de génération des réplicats + pseudo-absences : 
for (i in 1:number_of_replicates) {
  presences = xyFromCell(template, cells_Arbovirus) # récupérer les coordonnées du centre de gravité des cellule raster "1"
  cells_pseudo_absence = sample(cells_background, length(cells_Arbovirus), replace=F) 
  #aléotoire, sample() échantiller sans remplacement un certain nbr d'identifiants de cellules raster 
  #nombre cellule pseudo-abs = cellule raster taitées comme emplacement présence
  
  pseudo_absences = xyFromCell(template, cells_pseudo_absence) # coordonnée centroïde des cellules raster comme emplacement pseudo-absence
  
  data = rbind(cbind(rep(1,dim(presences)[1]),presences),
               cbind(rep(0,dim(pseudo_absences)[1]),pseudo_absences)) #COMBINER 
  
  colnames(data) = c("response", "longitude", "latitude")
  data = cbind(data, raster::extract(stack(envVariables), data[,c(2:3)])) #complet cadre données avec les valeurs environnementales 
  
  dataframes[[i]] = as.data.frame(data) 
  if (i == 1) print(str(dataframes[[i]])) 
}


#Etape 4 : ANALYSE DE L'AUTOCORRÉLATION SPATIALE (CORRÉLOGRAMMES)
#Le but est de trouver la taille des blocs de validation afin d'éviter une autocorrélation des points
#c'est à dire si deux points sont trop proches ou le modèle va plus lié le point à l'environnement mais le mettre au hazard

#Eviter les surajustement (s'adapte) => Cross validation spaciale 
par(oma=c(0,0,0,0), mar=c(2,2.2,0,0))
#Corrélation spatiale sur chaque réplicat 
for (i in 1:number_of_replicates) {
  data = dataframes[[i]]
  correlogram = ncf::correlog(data[,"longitude"], data[,"latitude"], data[,"response"],
                              na.rm=T, increment=50, resamp=0, latlon=T) #pas de 50km
  if (i == 1) { 
    plot(correlogram$mean.of.class, correlogram$correlation, ann=F, axes=F,
         lwd=0.2, cex=0.5, col=NA, ylim=c(-1,1.03), xlim=c(0,4000))
    abline(h=0, lwd=0.5, col=rgb(222,67,39,255,maxColorValue=255), lty=2)
    axis(side=1, lwd.tick=0.2, cex.axis=0.7, lwd=0.2, tck=-0.03,
         col.axis="gray30", mgp=c(0,0.00,0), at = seq(0,4000,500))
    axis(side=2, lwd.tick=0.2, cex.axis=0.7, lwd=0.2, tck=-0.03,
         col.axis="gray30", mgp=c(0,0.25,0), at=seq(-1.5,3,0.5))
    title(xlab="Distance (km)", cex.lab=0.9, mgp=c(0.9,0,0), col.lab="gray30")
    title(ylab="Correlation", cex.lab=0.9, mgp=c(1.3,0,0), col.lab="gray30")
  }
  lines(correlogram$mean.of.class[-1], correlogram$correlation[-1], lwd=0.1, col="gray60")
  # Ajout de la courbe du réplicat 'i' en gris transparent
  # On ignore le premier point [-1] qui est souvent à 1 (corrélation d'un point avec lui-même)
}
#A partir de 2100, on évite l'autocorrélation 


#Etape 5 : Entrainement des models de niche écologique (Chaque nouvel arbre essaie de corriger les erreurs de l'arbre précédent => optimiser)
theRanges=c(2100,2100)*1000 #distance spatiale (en dessous de 0 du graf d'avant)
gbm.x= envVariableNames 
gbm.y="response" #1 VS 0
offset=NULL;tree.complexity=5 #nombre de noeud par arbres => interactions possibles entre variables 
learning.rate=0.005 # assez conservatif 
bag.fraction=0.80 #80% données utilisées pour entrainement
site.weights=rep(1,dim(data)[1]) #ont à le même poids 
var.monotone=rep(0,length(gbm.x)) 

#VALIDATION CROISEE : 5 grp
n.folds=5
prev.stratify=TRUE
family="bernoulli"
n.trees=10 #BOOSTING nombre initiale d'arbres dans le modèle
step.size=5 #déviance prédictif
max.trees=10000 
#Arrêt
tolerance.method="auto"
tolerance= 0.001
plot.main=TRUE
plot.folds=FALSE
verbose=TRUE
silent=FALSE
#stocker 
keep.fold.models=FALSE
keep.fold.vector=FALSE
keep.fold.fit=FALSE


#ANALYSE :
AUCs=matrix(nrow=number_of_replicates,ncol=1) #vérifie si le résultat du modèle est fiable
colnames(AUCs)=c("AUC")
library(sf)
sf::sf_use_s2(FALSE)
brt_models=list()
predictions = list()
for(i in 1:number_of_replicates){
  data=dataframes[[i]]
  spdf=SpatialPointsDataFrame(data[c("longitude","latitude")],
                              data = data,
                              proj4string=crs(template))
  myblocks=cv_spatial(spdf,column="response",k=n.folds,size=theRanges[1],selection="random")
  fold.vector=myblocks$folds_ids 
  n.trees=10
  brt_models[[i]]=gbm.step(data,gbm.x,gbm.y,offset,fold.vector,tree.complexity,
                           learning.rate,bag.fraction,site.weights,var.monotone,
                           n.folds,prev.stratify,family,n.trees,step.size,
                           max.trees, tolerance.method,tolerance,plot.main,
                           plot.folds,verbose,silent,keep.fold.models,
                           keep.fold.vector,keep.fold.fit)
  AUCs[i,"AUC"]=brt_models[[i]]$cv.statistics$discrimination.mean
  
  dataframe=as.data.frame(stack(envVariables))
  dataframe=dataframe[which(!is.na(rowMeans(dataframe))),] #dataframeforthepredictionstep
  n.trees=brt_models[[i]]$gbm.call$best.trees #nbr optimal d'arbre
  type="response";single.tree=FALSE #parameterstosetforthepredict.gbmfunction:
  
  prediction=predict.gbm(brt_models[[i]],dataframe,n.trees,type,single.tree)
  buffer=envVariables[[1]];buffer[!is.na(buffer[])]=prediction;predictions[[i]]=buffer
}
write.csv(AUCs,"AUC_value_replicates.csv",row.names=F,quote=F)
saveRDS(brt_models,"BRT_model_replicates.rds")
saveRDS(predictions,"BRT_model_predictions.rds")  


#STEP6 RISQUE générale carte de la niche écologique :
predictions = readRDS("BRT_model_predictions.rds")
my_stack = stack(predictions) 
mean_risk_map = mean(my_stack)
par(mfrow=c(1,1), mar=c(3,3,3,4))
cols_consensus = rev(colorRampPalette(brewer.pal(9,"RdYlBu"))(100))
plot(mean_risk_map, col=cols_consensus, main="Carte de Consensus : Risque Moyen d'Arbovirus (n=50)", 
     axes=F, box=F)
plot(EU, add=T, border="gray30", lwd=0.7) # Ajoute les contours de l'Europe
plot(mean_risk_map, col=cols_consensus, legend.only=T, add=T, legend.width=1,
     legend.shrink=0.5, axis.args=list(cex.axis=0.8))

#7PREMIERs REPLICATs EXEMPLE : 
par(mfrow=c(1,7), oma=c(0,0,1.5,0), mar=c(0.75,0,0,0), lwd=0.2, col="gray30",
    col.axis="gray30", fg="gray30") # general graphical parameters
cols = rev(colorRampPalette(brewer.pal(9,"RdYlBu"))(131)[11:121]) # a frequently used
# "diverging" colour scale (from "RColorBrewer") to colour risk mapping outcome
for (i in 1:19) { # for the illustration, we here only plot the results for seven first replicates
  plot(predictions[[i]], col=cols, ann=F, legend=F, axes=F, box=F) # to plot the prediction raster
  plot(EU, add=T, border="gray50", lwd=0.5) # to add the contour of the African continent
  mtext("Ecological suitability", side=3, line=0.3, cex=0.65, col="gray30") # map title (1° part)
  mtext(paste0("(BRT replicate ",i,")"), side=3, line=-0.7, cex=0.65, col="gray30") # (2° part)
  plot(predictions[[i]], col=cols, legend.only=T, add=T, legend.width=0.5,
       legend.shrink=0.3, smallplot=c(0.10,0.80,0.09,0.12), adj=3,
       axis.args=list(cex.axis=0.65, lwd=0, lwd.tick=0.2, col.tick="gray30",
                      tck=-0.9, col="gray30", col.axis="gray30", line=0,
                      mgp=c(0,0.1,0)), alpha=1, side=3, horizontal=T) # to add the colour legend
}


# --- CALCUL DE LA VARIABILITÉ (INCERTITUDE) --- forcer le min à 0 et max à 1 
# 1. On calcule l'écart-type (Standard Deviation) entre les 50 réplicats
sd_risk_map = calc(my_stack, fun=sd)
# 2. On calcule le Coefficient de Variation (SD / Moyenne)
# +0.0001 pour éviter la division par zéro
cv_risk_map = sd_risk_map / (mean_risk_map + 0.0001)
# 3. CALCUL DU MAXIMUM COHÉRENT :
valeurs_cv = getValues(cv_risk_map)
max_coherent = quantile(valeurs_cv, 0.95, na.rm=TRUE)
max_coherent = round(max_coherent, 2)
cv_map_final = clamp(cv_risk_map, lower=0, upper=max_coherent)
par(mfrow=c(1,1), mar=c(3,3,3,4))
cols_cv = rev(colorRampPalette(brewer.pal(9,"RdYlBu"))(131)[11:121])
plot(cv_map_final, 
     col=cols_cv, 
     main=paste("Incertitude (CV) adaptée - Max cohérent :", max_coherent),
     axes=F, 
     box=F,
     zlim=c(0, max_coherent)) # L'échelle s'arrête exactement au max cohérent
plot(EU, add=T, border="gray30", lwd=0.5)
#le bus c'est d'avoir des résultats faibles qui sont des incertitudes faibles = fiable (à l'opposé des points rouges) 


#Etape 7:  assessing prédiction performance de le niche écologique :
AUCs = read.csv("AUC_value_replicates.csv", head=T)
cat("Mean AUC = ",round(mean(AUCs[,1]),2),
    ", AUC range = [",round(min(AUCs),2),", ",round(max(AUCs),2),"]","\n",sep="")
# RESULTAT : Mean AUC = 0.86, AUC range = [0.76, 0.93] #on voit que c'est bon

brt_models=readRDS("BRT_model_replicates.rds")
SI_ppcs=rep(NA, length(brt_models))
thresholds=rep(NA, length(brt_models))

for(i in 1:length(brt_models)) {
  tmp=matrix(nrow=101,ncol=2) 
  colnames(tmp)= c("threshold","SIppc");tmp[,"threshold"]=seq(0,1,0.01)
  dataframe=brt_models[[i]]$gbm.call$dataframe
  responses=dataframe$response;data=dataframe[,4:dim(dataframe)[2]]
  n.trees=brt_models[[i]]$gbm.call$best.trees;type="response";single.tree=FALSE
  prediction= predict.gbm(brt_models[[i]],data,n.trees,type,single.tree)
  P= sum(responses==1)
  A= sum(responses==0)
  prev=P/(P+A)
  x=(P/A)*((1-prev)/prev);SI_ppc= 0
  for (threshold in seq(0,1,0.01)) {
    TP=length(which((responses==1)&(prediction>=threshold)))#Vraies positives
    FN=length(which((responses==1)&(prediction<threshold)))#faux négatives
    FP_pa= length(which((responses==0)&(prediction>=threshold)))
    SI_ppc_tmp=(2*TP)/((2*TP)+(x*FP_pa)+(FN)) 
    tmp[which(tmp[,"threshold"]==threshold),"SIppc"]=SI_ppc_tmp
    if (SI_ppc< SI_ppc_tmp){
      SI_ppc=SI_ppc_tmp;optimised_threshold=threshold
    }
  }
  SI_ppcs[i]=SI_ppc;thresholds[i]=optimised_threshold
}
mean_SIppc=round(mean(SI_ppcs),2);mean_thres=round(mean(thresholds),2) #meanSIppc
min_SIppc=round(min(SI_ppcs),2);min_thres=round(min(thresholds),2)#minimumSIppc
max_SIppc=round(max(SI_ppcs),2);max_thres=round(max(thresholds),2)#maximumSIppc
cat("MeanSIppc=",mean_SIppc,",SIppcrange=[",min_SIppc,",",max_SIppc,"]","\n",sep="")
#MeanSIppc=0.96,SIppcrange=[0.93,0.98]


#Etape 8 : les importances relatives du virus en fonction des variables de l'environnment : 
relative_importances=matrix(nrow=length(brt_models),ncol=length(envVariables))
colnames(relative_importances)=envVariableNames
brt_models=readRDS("BRT_model_replicates.rds")
for(i in 1:length(brt_models)) {
  for (j in 1:length(envVariables)) {
    relative_importances[i,j]=summary(brt_models[[i]])[names(envVariables[[j]]),"rel.inf"]
  }
}
write.table(relative_importances,"Relative_importances.csv",row.names=F,quote=F,sep=",")
relative_importances=read.csv("Relative_importances.csv",head=T)
RI_summary=matrix(nrow=length(envVariables),ncol=1)
rownames(RI_summary)=envVariableNames;colnames(RI_summary)=c("meanRI[95%CI]")
for(i in 1:dim(relative_importances)[2]) {
  mean_RI=round(mean(relative_importances[,i]),1)
  ci95_RI=round(t.test(relative_importances[,i])$conf.int[1:2],1)
  RI_summary[i,1]=paste0(mean_RI,"[",ci95_RI[1],",",ci95_RI[2],"]")
}
RI_summary



#STEP9 : visual response curves (visualisation de la niche écologique du virus)
brt_models=readRDS("BRT_model_replicates.rds")
sp= SpatialPoints(dataframes[[1]][which(dataframes[[1]][,"response"]==1),2:3])
envVariableValues=matrix(nrow=3,ncol=length(envVariables))
colnames(envVariableValues)=envVariableNames
row.names(envVariableValues)=c("median","minV","maxV")
for(i in 1:length(envVariables)) {
  points=rasterize(sp,envVariables[[i]])
  rast=envVariables[[i]];rast[is.na(points)]=NA
  minV= min(rast[],na.rm=T);maxV=max(rast[],na.rm=T)
  envVariableValues[,i]=cbind(median(rast[],na.rm=T),minV,maxV)
}
par(mfrow=c(5,4),oma=c(0,0,0,0),mar=c(2,1.2,0.5,0.5),lwd=0.2,col="gray30")
envVariableTitles=c("croplands_all_categories","human_pop_density_log10","managed_pasture_and_rangeland","Precipitation_inFall",
                    "Precipitation_spring","Precipitation_summer","Precipitation_winter","primary_forest_areas","primary_non_forest_areas","relative_Humidity_inFall","relative_Humidity_spring",
                    "relative_Humidity_summer","relative_Humidity_winter","secondary_forest_areas","secondary_non_forest_areas","temperature_inFall","temperature_spring","temperature_summer","temperature_winter")
#mar=c(2.5,2,1,0.2),lwd=0.2
for (i in c(1:19)) { # to get a plot per environmental variable in a specific order
  valuesInterval = (envVariableValues["maxV",i]-envVariableValues["minV",i])/100 
  # Estimer les courbes établies à partir de 100 valeurs comprises entre les valeurs minimales et maximales enregistrées
  # pour le facteur environnemental considéré, dans toutes les cellules de la grille considérées comme des emplacements de présence
  dataframe = data.frame(matrix(nrow=length(seq(envVariableValues["minV",i],
                                                envVariableValues["maxV",i],valuesInterval)),
                                ncol=length(envVariables))) # Ce tableau de données regroupera, pour
  # chaque facteur environnemental (colonnes), 100 valeurs : la plage susmentionnée de 100 valeurs
  # pour le facteur environnemental cible, et 100 fois la valeur médiane pour les autres facteurs
  colnames(dataframe) = envVariableNames
  for (j in 1:length(envVariables)) {
    interval = (envVariableValues["maxV",j]-envVariableValues["minV",j])/100
    if (i == j) {
      dataframe[,envVariableNames[j]] = seq(envVariableValues["minV",j],
                                            envVariableValues["maxV",j],interval)
    } else {
      dataframe[,envVariableNames[j]] = rep(envVariableValues["median",j],
                                            dim(dataframe)[1])
    }
  }
  predictions = list() # Cette liste contiendra les valeurs prédites pour l'adéquation écologique
  # en tenant compte des valeurs des lignes successives du « dataframe » généré ci-dessus
  for (j in 1:length(brt_models)) { 
    n.trees = brt_models[[j]]$gbm.call$best.trees; type = "response"; single.tree = FALSE
    prediction = predict.gbm(brt_models[[j]], newdata=dataframe, n.trees, type, single.tree)
    if (j == 1) { 
      minX = min(dataframe[,envVariableNames[i]])
      maxX = max(dataframe[,envVariableNames[i]])
    } else {
      if (minX > min(dataframe[,envVariableNames[i]])) {
        minX = min(dataframe[,envVariableNames[i]])
      }
      if (maxX < max(dataframe[,envVariableNames[i]])) {
        maxX = max(ddataframe[,envVariableNames[i]])
      }
    }
    predictions[[j]] = prediction
  }
  col = rgb(222,67,39,255,maxColorValue=255) # red
  for (j in 1:length(brt_models)) {
    if (j == 1) {
      plot(dataframe[,envVariableNames[i]], predictions[[j]], col=col, ann=F,
           axes=F, lwd=0.2, type="l", xlim=c(minX,maxX), ylim=c(0,1))
    } else {
      lines(dataframe[,envVariableNames[i]], predictions[[j]], col=col, lwd=0.2)
    }
  }
  axis(side=1, lwd.tick=0.2, cex.axis=0.7, lwd=0, tck=-0.040, col.axis="gray30", mgp=c(0,0.15,0))
  axis(side=2, lwd.tick=0.2, cex.axis=0.7, lwd=0, tck=-0.040, col.axis="gray30", mgp=c(0,0.4,0))
  title(xlab=envVariableTitles[i], cex.lab=0.9, mgp=c(1.0,0,0), col.lab="gray30")
  box(lwd=0.2, col="gray30")#at=seq(0.7, 1, 0.05)
}

#pdf("C:/Users/hoste/OneDrive - Université Libre de Bruxelles/Documents/Cours/VIRUS/Etape9.pdf",width =10, height =9 )
#par (mfrow=c(5,4), oma=c(0,0,0,0),mar=c(2,1.2,0.5,0.5),lwd=0.2,col="gray30",bg="white") #axe de0-1

