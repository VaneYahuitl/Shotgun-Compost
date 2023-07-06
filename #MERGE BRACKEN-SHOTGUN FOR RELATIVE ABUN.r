#MERGE BRACKEN-SHOTGUN FOR RELATIVE ABUNDANCE
library(readr)
library(dplyr)

#sHOTGUN DATA
setwd("~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTENCO/")
#ImpRet TXT files and change the column names

IXT_165<- read_tsv("M165_bracken_species", col_names = TRUE, show_col_types = FALSE)
IXT_165<- IXT_165[,c(1,7)]
columnas<- c("Taxonomia", "IX165E")
colnames(IXT_165)<- columnas
IXT_164<- read_tsv("M164_bracken_species", col_names = TRUE, show_col_types = FALSE)
IXT_164<- IXT_164[,c(1,7)]
columnas<- c("Taxonomia", "IX164O")
colnames(IXT_164)<- columnas
IXT_176<- read_tsv("M176_bracken_species", col_names = TRUE, show_col_types = FALSE)
IXT_176<- IXT_176[,c(1,7)]
columnas<- c("Taxonomia", "IX1760")
colnames(IXT_176)<- columnas
IXT_177<- read_tsv("M177_bracken_species", col_names = TRUE, show_col_types = FALSE)
IXT_177<- IXT_177[,c(1,7)]
columnas<- c("Taxonomia", "IX177E")
colnames(IXT_177)<- columnas
IXT_188<- read_tsv("M188_bracken_species", col_names = TRUE, show_col_types = FALSE)
IXT_188<- IXT_188[,c(1,7)]
columnas<- c("Taxonomia", "IX188O")
colnames(IXT_188)<- columnas
IXT_189<- read_tsv("M189_bracken_species", col_names = TRUE, show_col_types = FALSE)
IXT_189<- IXT_189[,c(1,7)]
columnas<- c("Taxonomia", "IX189E")
colnames(IXT_189)<- columnas

#Merge the Onset files
IXT_164_176<-merge(x = IXT_164, y = IXT_176, all = TRUE)
IXT_ONSET<-merge(x = IXT_164_176, y = IXT_188, all = TRUE)
#sAVE AS CSV
write.csv(IXT_ONSET,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTENCO/merge/IXTENCO_ONSET_relab.csv", row.names=FALSE)
#MERGE THE END SAMPLES
IXT_165_177<-merge(x = IXT_165, y = IXT_177, all = TRUE)
IXT_END<-merge(x = IXT_165_177, y = IXT_189, all = TRUE)
#SAVE AS csv
write.csv(IXT_END,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTENCO/merge/IXTENCO_END_relab.csv", row.names=FALSE)
#MERGE AND SAVE THE TABLE
IXT_ALL<-merge(x = IXT_ONSET, y = IXT_END, all = TRUE)
write.csv(IXT_ALL,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTENCO/merge/IXTENCO_ALL_relab.csv", row.names=FALSE)

##############
##########################      IXTACUIXTLA   ####################
#############################                   ############################

###### IXTACUIXTLA MERGE####

setwd("~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTACUITLA/")

ICL_129<- read_tsv("M129_bracken_species", col_names = TRUE, show_col_types = FALSE)
ICL_129<- ICL_129[,c(1,7)]
columnas<- c("Taxonomia", "ICL129O")
colnames(ICL_129)<- columnas
ICL_141<- read_tsv("M141_bracken_species", col_names = TRUE, show_col_types = FALSE)
ICL_141<- ICL_141[,c(1,7)]
columnas<- c("Taxonomia", "ICL141O")
colnames(ICL_141)<- columnas
ICL_142<- read_tsv("M142_bracken_species", col_names = TRUE, show_col_types = FALSE)
ICL_142<- ICL_142[,c(1,7)]
columnas<- c("Taxonomia", "ICL142E")
colnames(ICL_142)<- columnas
ICL_153<- read_tsv("M153_bracken_species", col_names = TRUE, show_col_types = FALSE)
ICL_153<- ICL_153[,c(1,7)]
columnas<- c("Taxonomia", "ICL153O")
colnames(ICL_153)<- columnas
ICL_154<- read_tsv("M154_bracken_species", col_names = TRUE, show_col_types = FALSE)
ICL_154<- ICL_154[,c(1,7)]
columnas<- c("Taxonomia", "ICL154E")
colnames(ICL_154)<- columnas
ICL_166<- read_tsv("M166_bracken_species", col_names = TRUE, show_col_types = FALSE)
ICL_166<- ICL_166[,c(1,7)]
columnas<- c("Taxonomia", "ICL166E")
colnames(ICL_166)<- columnas

#Merge the Onset files
ICL_129_141<-merge(x = ICL_129, y = ICL_141, all = TRUE)
ICL_ONSET<-merge(x = ICL_129_141, y = ICL_153, all = TRUE)
#sAVE AS CSV
write.csv(ICL_ONSET,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTACUITLA/merge/ICL_ONSET_relab.csv", row.names=FALSE)
#MERGE THE END SAMPLES
ICL_142_154<-merge(x = ICL_142, y = ICL_154, all = TRUE)
ICL_END<-merge(x = ICL_142_154, y = ICL_166, all = TRUE)
#SAVE AS csv
write.csv(ICL_END,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTACUITLA/merge/ICL_END_relab.csv", row.names=FALSE)
#MERGE AND SAVE THE TABLE
ICL_ALL<-merge(x = ICL_ONSET, y = ICL_END, all = TRUE)
write.csv(ICL_ALL,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTACUITLA/merge/ICL_ALL_relab.csv", row.names=FALSE)

#################
#############3333333
##########################
#################### ALTAMIRA ###################
setwd("~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-ALTAMIRA/")
#Impoet metaphlan-like files and change the column names

ALT_105<- read_tsv("M105_bracken_species", col_names = TRUE, show_col_types = FALSE)
ALT_105<- ALT_105[,c(1,7)]
columnas<- c("Taxonomia", "ALT105O")
colnames(ALT_105)<- columnas
ALT_106<- read_tsv("M106_bracken_species", col_names = TRUE, show_col_types = FALSE)
ALT_106<- ALT_106[,c(1,7)]
columnas<- c("Taxonomia", "ALT106E")
colnames(ALT_106)<- columnas
ALT_117<- read_tsv("M117_bracken_species", col_names = TRUE, show_col_types = FALSE)
ALT_117<- ALT_117[,c(1,7)]
columnas<- c("Taxonomia", "ALT117O")
colnames(ALT_117)<- columnas
ALT_118<- read_tsv("M118_bracken_species", col_names = TRUE, show_col_types = FALSE)
ALT_118<- ALT_118[,c(1,7)]
columnas<- c("Taxonomia", "ALT118E")
colnames(ALT_118)<- columnas
ALT_130<- read_tsv("M130_bracken_species", col_names = TRUE, show_col_types = FALSE)
ALT_130<- ALT_130[,c(1,7)]
columnas<- c("Taxonomia", "ALT130E")
colnames(ALT_130)<- columnas
ALT_152<- read_tsv("M152_bracken_species", col_names = TRUE, show_col_types = FALSE)
ALT_152<- ALT_152[,c(1,7)]
columnas<- c("Taxonomia", "ALT152O")
colnames(ALT_152)<- columnas

#Merge the Onset files
ALT_105_117<-merge(x = ALT_105, y = ALT_117, all = TRUE)
ALT_ONSET<-merge(x = ALT_105_117, y = ALT_152, all = TRUE)
#sAVE AS CSV
write.csv(ALT_ONSET,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-ALTAMIRA/merge/ALT_ONSET_relab.csv", row.names=FALSE)
#MERGE THE END SAMPLES
ALT_106_118<-merge(x = ALT_106, y = ALT_118, all = TRUE)
ALT_END<-merge(x = ALT_106_118, y = ALT_130, all = TRUE)
#SAVE AS csv
write.csv(ALT_END,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-ALTAMIRA/merge/ALT_END_relab.csv", row.names=FALSE)
#MERGE AND SAVE THE TABLE
ALT_ALL<-merge(x = ALT_ONSET, y = ALT_END, all = TRUE)
write.csv(ALT_ALL,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-ALTAMIRA/merge/ALT_ALL_relab.csv", row.names=FALSE)
