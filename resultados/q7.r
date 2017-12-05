## Gerar projeção em 2D dos objetivos de custo, duração e horas extras para as instâncias ACAD e PARM
# install.packages("gdtools")
#install.packages('ggplot2', dep = TRUE)
#install.packages('cowplot', dep = TRUE)
library(ggplot2)
library(cowplot)

options(tz="Europe/Berlin")
setwd("/Users/andrefarzat/Documents/mc2/dados")

NSGA        <- cbind(read.table(file="data_t7_nsga_150k_c50_2x_error1_frontier_obj.txt", header=TRUE),  list(metodo = "NSGA"));
NSGANoError <- cbind(read.table(file="data_t7_nsga_150k_c50_2x_noerror_frontier_obj.txt", header=TRUE), list(metodo = "NSGANoError"));
mar         <- cbind(read.table(file="data_t7_Margarine_error1_frontier_obj.txt", header=TRUE),         list(metodo = "mar"));
sh          <- cbind(read.table(file="data_t7_SecondHalf_error1_frontier_obj.txt", header=TRUE),        list(metodo = "sh"));
cpm         <- cbind(read.table(file="data_t7_CPM_error1_frontier_obj.txt", header=TRUE),               list(metodo = "cpm"));

dados       <- rbind(NSGA, NSGANoError, mar, sh, cpm)

dadosACAD   <- subset(dados, inst == "ACAD");
dadosPARM   <- subset(dados, inst == "PARM");

shapes <- c(1, 1, 1, 2, 3)
colors <- c("light gray", "dark gray", "black", "black", "black")

plotAcadMkspanCusto  <- ggplot(dadosACAD, aes(x=mks, y=cst/1000, color=metodo, shape=metodo)) +
                        geom_point() +
                        scale_shape_manual(values=shapes) +
                        scale_color_manual(values=colors) +
                        labs(y = "Cost(1000$)", x = "Makespan (days)") +
                        ggtitle("ACAD") +
                        theme(plot.title = element_text(face="bold", hjust=0.98,margin = margin(b = -20)), legend.position="none", plot.margin=grid::unit(c(0.3,0.1,0.1,0.1), "in"))

plotAcadOvtMkspan    <- ggplot(dadosACAD, aes(x=noh*10, y=mks, color=metodo, shape=metodo)) +
                        geom_point() +
                        scale_shape_manual(values=shapes) +
                        scale_color_manual(values=colors) +
                        labs(y = "Makespan (days)", x = "Overtime (hours)") +
                        ggtitle("ACAD") +
                        theme(plot.title = element_text(face="bold", hjust=0.98,margin = margin(b = -20)), legend.position="none", plot.margin=grid::unit(c(0.3,0.1,0.1,0.1), "in"))

plotAcadOvtCusto     <- ggplot(dadosACAD,aes(x=noh*10, y=cst/1000, color=metodo, shape=metodo)) +
                        geom_point() +
                        scale_shape_manual(values=shapes) +
                        scale_color_manual(values=colors) +
                        labs(y = "Cost(1000$)", x = "Overtime (hours)") +
                        ggtitle("ACAD") +
                        theme(plot.title = element_text(face="bold", hjust=0.98,margin = margin(b = -20)), legend.position="none", plot.margin=grid::unit(c(0.3,0.1,0.1,0.1), "in"))

plotParmMkspanCusto  <- ggplot(dadosPARM,aes(x=mks,y=cst/1000,color=metodo,shape=metodo)) +
                        geom_point() +
                        scale_shape_manual(values=shapes) +
                        scale_color_manual(values=colors) +
                        labs(y = "Cost(1000$)", x = "Makespan (days)") +
                        ggtitle("PARM")+
                        theme(plot.title = element_text(face="bold", hjust=0.98,margin = margin(b = -20)), legend.position="none", plot.margin=grid::unit(c(0.3,0.1,0.1,0.1), "in"))

plotParmOvtMkspan    <- ggplot(dadosPARM,aes(x=noh*10, y=mks, color=metodo, shape=metodo)) +
                        geom_point() +
                        scale_shape_manual(values=shapes) +
                        scale_color_manual(values=colors) +
                        labs(y = "Makespan (days)", x = "Overtime (hours)") +
                        ggtitle("PARM")+
                        theme(plot.title = element_text(face="bold", hjust=0.98,margin = margin(b = -20)), legend.position="none", plot.margin=grid::unit(c(0.3,0.1,0.1,0.1), "in"))

plotParmOvtCusto     <- ggplot(dadosPARM,aes(x=noh*10, y=cst/1000, color=metodo, shape=metodo)) +
                        geom_point() +
                        scale_shape_manual(values=shapes) +
                        scale_color_manual(values=colors) +
                        labs(y = "Cost(1000$)", x = "Overtime (hours)") +
                        ggtitle("PARM")+
                        theme(plot.title = element_text(face="bold", hjust=0.98,margin = margin(b = -20)), legend.position="none", plot.margin=grid::unit(c(0.3,0.1,0.1,0.1), "in"))

final <- plot_grid(plotAcadMkspanCusto, plotAcadOvtMkspan, plotAcadOvtCusto, plotParmMkspanCusto, plotParmOvtMkspan, plotParmOvtCusto, nrow=2, ncol=3)

ggsave("../resultados/GrafQ7.pdf", final, width = 10, height = 4)