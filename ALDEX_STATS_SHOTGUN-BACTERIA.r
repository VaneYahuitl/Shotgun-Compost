#PCA-SHOTGUN-BACTERIA-ALDEX

#COMPOST
#Vamos a llamar a la paquetería que nos va a permitir leer archivos de tipo ".csv"
library(readr)  
library(textshape)
library(ALDEx2)
library(FactoMineR)
library(vegan)
#Mi Dataframe debe tener

#  B1ACD7	0	0	0	19	0	0	0	130	10	0
setwd("~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa/FILES_FILT/")

Bact_all <- read.csv("Bacteria_all_counts_b.csv", header= TRUE, fileEncoding = 'UTF-8-BOM')
View(Bact_all)

#SP	IX164	IX176	IX188	IX165	IX177	IX189 ..............7 columns for 6 samples
#Candidatus_Babela_massiliensis	NA	19	NA	22	29	44
#Candidatus_Chromulinivorax_destructor	NA	NA	NA	13	10	23
#Candidatus_Chazhemtobacterium_aquaticus	NA	NA	NA	10	NA	NA
#Acidisarcina_polymorpha	23	99	46	70	53	56
#Acidobacterium_capsulatum	19	18	14	154	96	84
#Alloacidobacterium_dinghuense	48	157	122	68	68	51
#Candidatus_Koribacter_versatilis	16	26	14	90	56	58
#Edaphobacter_sp._12200R-103	18	NA	NA	76	40	39
#Edaphobacter_sp._4G125	10	25	NA	29	21	27
#.
#.......7040 obs 
#Coloco mis rownames para dejar una matriz enteramente numerica
Bact_all<-textshape::column_to_rownames(Bact_all, loc = 1)


#Selecciono condicionales 

conds <- c(rep("Onset", 9), rep("End", 9))

x.all <- aldex(Bact_all, conds, mc.samples=16, test="t", effect=TRUE,
               include.sample.summary=FALSE, denom="all", verbose=FALSE)

#Creamos un grafico de dispersión 
par(mfrow=c(1,2))
aldex.plot(x.all, type="MA", test="welch", xlab="Log-ratio abundance",
           ylab="Difference")
aldex.plot(x.all, type="MW", test="welch", xlab="Dispersion",
           ylab="Difference")


#Aplico función CLR 
counts_All_clr <- aldex.clr(Bact_all, mc.samples = 128, denom = "all", verbose = TRUE, useMC = TRUE)

#Genero una DataFrame
df_bact <- data.frame(getMonteCarloSample(counts_All_clr,1))
View(df_bact)

#Le hago PCA Y aparecerán imágenes en la ventana de plots, debo guardarlos porque los ejes son los mismos que tendrán mis gráficos finales

PCA_spll <- PCA(df_bact)

#Genero archivo de coordenadas de los Plots visualizados para muestras
Coord_sample_all <- data.frame(PCA_spll$var$coord)
View(Coord_sample_all)

#Genero archivo de coordenadas de los Plots visualizados para especies
Coord_tax_sp_all <- data.frame(PCA_spll$ind$coord)
View(Coord_tax_sp_all)

write.csv(Coord_sample_all,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/PCA_SAMPLE_BACT_ALL.csv", row.names=FALSE)
write.csv(Coord_sp_all,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/PCA_SPECIE_BACT_ALL.csv", row.names=FALSE)

#########################################################
#################      SIZE EFFECT    ###################
########################################################

#Cargo ARCHIVO CON ROW-NAMES
#Necesito colocar mis Rownames
#Establezco mis Condicionales, los tratamientos que voy a comparar por ejemplo 
#View(conds)

#Aplico la función .clr para enfoque modular, transformandolos a razones logarítmicas
#Se reocmienda un valor de 128 en Monte carlo Samples para un álculo riguroso del tamaño del efecto
#del tratamiento medido, al menos 16 para caso de anovas
x_c <- aldex.clr(Bact_all, conds, mc.samples=999, denom="all", verbose=FALSE)
x_clr <- aldex.clr(Bact_all, conds, mc.samples=128, denom="all", verbose=FALSE)

View(x_c)

#a los resultados de la tabla "X" se les pueden aplicar pruebas estadísticas 
#Prueba Kruskal wallis
x_kw_bacterias_compost <- aldex.kw(x_clr)
View(x_kw_bacterias_compost)
#Voy guardando todo 
write.table(x_kw_bacterias_compost, "kRUSKALWALLIS_bact_sp_COUNTS_all.tsv", sep = "\t")

#pRUEBA t de Student
x_tt_bact <- aldex.ttest(x_clr, paired.test = TRUE)
View(x_tt_bact)

x <- aldex.clr(Bact_all, conds, mc.samples=16, denom = "all")
ttest.test <- aldex.ttest(x)

write.table(x_tt_bact, "ttest_BACT_COMP_SP.tsv", sep = "\t")


#Tamaño del efecto #Con un mc samples de 999 o 1000 
x.effect_bacterias_sp <- aldex.effect(x_c, CI=T, verbose=FALSE)
View(x.effect_bacterias_sp)
write.table(x.effect_bacterias_sp, "efecto_bacterias_SP_compost.txt", sep = "\t")



#Fusionar en un dataframe  varias pruebas (counts.tt y x_test es la misma)
x_all_c <- data.frame(x.effect_bacterias_sp, x_kw_bacterias_compost, x_tt_bact)
View(x_all_c)
write.table(x_all_c, "all_test_bacterias_compost_SP.txt", sep = "\t")


#Puedes plotear el tamaño del efecto
par(mfrow=c(1,2))
aldex.plot(x_all_c, type="MA", test="welch")
aldex.plot(x_all_c, type="MW", test="welch") 

#Encontrar los valores significativos menor o igual que ..."<="
x_ss_c <- subset(x_all_c, wi.eBH <= 0.05)  
View(x_ss_c)
write.table(x_ss_c, "significant_chinampa_COUNTS_all.txt", sep = "\t")

#Encontrar los no significativos 
x_ns_c <- subset(x_all_c, wi.eBH > 0.05)
View(x_ns_c)


#ENCUENTRA LOS VALORES SIGNIFICATIVOS PARA TODAS LAS PRUEBAS QUE SE HICIERON 
found.by.all <- which(x_all_c$we.eBH < 0.05 &
                        + x_all_c$wi.eBH < 0.05 & x_all_c$kw.eBH < 0.05)
View(found.by.all)
# plot the within and between variation of the data
plot(x_all_c$diff.win, x_all_c$diff.btw, pch=19, cex=0.3, col=rgb(0,0,0,0.3),
     + xlab="Difference within", ylab="Difference between")
points(x_all_c$diff.win[found.by.all], x_all_c$diff.btw[found.by.all], pch=19,
       + cex=0.5, col=rgb(0,0,1,0.5))
points(x_all_c$diff.win[found.by.all], x_all_c$diff.btw[found.by.all], pch=19,
       + cex=0.5, col=rgb(1,0,0,1))
abline(0,1,lty=2)
abline(0,-1,lty=2)


####   PLOT 2
plot(x_ns_c$effect, x_ns_c$wi.eBH, cex=0.7, pch=19, col = "black", xlab="Effect size", ylab="P value", main="Bacteria Species Compost Onset vs End", ylim=c(0,1), xlim=c(-1.5,1.5))
points(x_ss_c$effect, x_ss_c$wi.eBH, cex=0.7, pch=19, col = "red")
abline(h=0.05, lty=5, lwd =2, col="goldenrod3")
abline(v=0.8, lty=2)
abline(v=-0.8, lty=2)




