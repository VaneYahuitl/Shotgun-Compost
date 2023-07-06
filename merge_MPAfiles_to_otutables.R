library(readr)
library(dplyr)

###### IXTENCO MERGE
setwd("~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTENCO/")

#Impoet metaphlan-like files and change the column names

IXT_165<- read_tsv("M165_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "IX165")
colnames(IXT_165)<- columnas
IXT_164<- read_tsv("M164_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "IX164")
colnames(IXT_164)<- columnas
IXT_176<- read_tsv("M176_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "IX176")
colnames(IXT_176)<- columnas
IXT_177<- read_tsv("M177_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "IX177")
colnames(IXT_177)<- columnas
IXT_188<- read_tsv("M188_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "IX188")
colnames(IXT_188)<- columnas
IXT_189<- read_tsv("M189_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "IX189")
colnames(IXT_189)<- columnas

#Merge the Onset files
IXT_164_176<-merge(x = IXT_164, y = IXT_176, all = TRUE)
IXT_ONSET<-merge(x = IXT_164_176, y = IXT_188, all = TRUE)
#sAVE AS CSV
write.csv(IXT_ONSET,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTENCO/merge/IXTENCO_ONSET_counts.csv", row.names=FALSE)

#MERGE THE END SAMPLES
IXT_165_177<-merge(x = IXT_165, y = IXT_177, all = TRUE)
IXT_END<-merge(x = IXT_165_177, y = IXT_189, all = TRUE)
write.csv(IXT_END,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTENCO/merge/IXTENCO_END_counts.csv", row.names=FALSE)

#MERGE AND SAVE THE TABLE
IXT_ALL<-merge(x = IXT_ONSET, y = IXT_END, all = TRUE)
write.csv(IXT_ALL,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTENCO/merge/IXTENCO_ALL_counts.csv", row.names=FALSE)

#FILTRAR POR TAXONOMIA ASOCIADA A ESPECIE
#IMPORTO UNA DATAFRAME DE COUNTS CON | reemplazado por ;
#Ixtenco_all<- read.csv("IXTENCO_ALL.csv", header= TRUE, fileEncoding = 'UTF-8-BOM')
##Ixtenco_TAX<- read.csv("taxonomia_ixtenco.csv", header= TRUE, fileEncoding = 'UTF-8-BOM')
#IXTENCO_taxa_all<- merge(x =Ixtenco_TAX , y =Ixtenco_all, all = TRUE)
#IXTENCO_taxa_all
#IXTENCO_TAX_O<- merge(x =Ixtenco_TAX , y =IXT_ONSET, all = TRUE)
#IXTENCO_TAX_O
#IXTENCO_TAX_E<- merge(Ixtenco_TAX, IXT_END, by = Taxonomia)
#IXTENCO_TAX_E


###### IXTACUIXTLA MERGE####

setwd("~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTACUITLA/")

#Impoet metaphlan-like files and change the column names

ICL_129<- read_tsv("M129_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "IC129O")
colnames(ICL_129)<- columnas
ICL_141<- read_tsv("M141_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "IC141O")
colnames(ICL_141)<- columnas
ICL_142<- read_tsv("M142_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "IC142E")
colnames(ICL_142)<- columnas
ICL_153<- read_tsv("M153_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "IC153O")
colnames(ICL_153)<- columnas
ICL_154<- read_tsv("M154_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "IC154E")
colnames(ICL_154)<- columnas
ICL_166<- read_tsv("M166_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "IC166E")
colnames(ICL_166)<- columnas

#Merge the Onset files

ICL_129_141<-merge(x = ICL_129, y = ICL_141, all = TRUE)
ICL_ONSET<-merge(x = ICL_129_141, y = ICL_153, all = TRUE)
#sAVE AS TSV
#write.table(x=ICL_ONSET, quote = FALSE, sep = "\t", file = "~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTACUITLA/IXTACUITLA_ONSET")
write.csv(ICL_ONSET,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTACUITLA/merge/ICL_ONSET_counts.csv", row.names=FALSE)
#MERGE THE END SAMPLES
ICL_142_154<-merge(x = ICL_142, y = ICL_154, all = TRUE)
ICL_END<-merge(x = ICL_142_154, y = ICL_166, all = TRUE)
#SAVE AS TSV
#write.table(x=ICL_END, quote = FALSE, sep = "\t", file = "~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTACUITLA/IXTACUITLA_END")
write.csv(ICL_END,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTACUITLA/merge/ICL_END_counts.csv", row.names=FALSE)
#MERGE AND SAVE THE TABLE
ICL_ALL<-merge(x = ICL_ONSET, y = ICL_END, all = TRUE)
write.csv(ICL_ALL,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTACUITLA/merge/ICC_ALL_counts.csv", row.names=FALSE)


#################### ALTAMIRA ###################
setwd("~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-ALTAMIRA/")
#Impoet metaphlan-like files and change the column names

ALT_105<- read_tsv("M105_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "AL105O")
colnames(ALT_105)<- columnas

ALT_106<- read_tsv("M106_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "AL106E")
colnames(ALT_106)<- columnas
ALT_117<- read_tsv("M117_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "AL117O")
colnames(ALT_117)<- columnas
ALT_118<- read_tsv("M118_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "AL118E")
colnames(ALT_118)<- columnas
ALT_130<- read_tsv("M130_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "AL130E")
colnames(ALT_130)<- columnas
ALT_152<- read_tsv("M152_B_SPECIES.MPA.TXT", col_names = FALSE, show_col_types = FALSE)
columnas<- c("Taxonomia", "AL152O")
colnames(ALT_152)<- columnas

#Merge the Onset files
ALT_105_117<-merge(x = ALT_105, y = ALT_117, all = TRUE)
ALT_ONSET<-merge(x = ALT_105_117, y = ALT_152, all = TRUE)
#sAVE AS CSV
write.csv(ALT_ONSET,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-ALTAMIRA/merge/ALTAMIRA_ONSET_counts.csv", row.names=FALSE)

#MERGE THE END SAMPLES
ALT_106_118<-merge(x = ALT_106, y = ALT_118, all = TRUE)
ALT_END<-merge(x = ALT_106_118, y = ALT_130, all = TRUE)
write.csv(ALT_END,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-ALTAMIRA/merge/ALTAMIRA_END_counts.csv", row.names=FALSE)

#MERGE AND SAVE THE TABLE
ALT_ALL<-merge(x = ALT_ONSET, y = ALT_END, all = TRUE)
write.csv(ALT_ALL,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-ALTAMIRA/merge/ALTAMIRA_ALL_counts.csv", row.names=FALSE)

############################################
###############################
########### MERGE ALL SITES

setwd("~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTENCO/merge/")
Ixt_all<- read.csv("IXTENCO_ALL_counts.csv", header= TRUE, fileEncoding = 'UTF-8-BOM')
setwd("~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-IXTACUITLA/merge/")
ICC_all<- read.csv("ICC_ALL_counts.csv", header= TRUE, fileEncoding = 'UTF-8-BOM')
setwd("~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/TAX-ALTAMIRA/merge/")
Altamira_all<- read.csv("ALTAMIRA_ALL_counts.csv", header= TRUE, fileEncoding = 'UTF-8-BOM')

ALL_IXT_ICC<-merge(x = Ixt_all, y = ICC_all, all = TRUE)

ALL_3COMP<-merge(x = ALL_IXT_ICC, y = Altamira_all, all = TRUE)

write.csv(ALL_3COMP,"~/ExperimentoComposta/KRAKEN2_RESULTS/Taxa-Jesus/3COMPOST_ALL_counts.csv", row.names=FALSE)

