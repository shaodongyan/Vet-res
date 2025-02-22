library(tidyverse)
library(ggstatsplot)
library(ggplot2)

setwd("/Users/R/carpet/Pathogen/")
temp_all=read.csv("对比.csv")


p=ggwithinstats(
  data  = temp_all,
  x     = Group,
  y     = Percent,  
  type = "p",
  effsize.type = "g")
p






library(ggsci)
library(ggstatsplot)
theme_MJ <- function(..., bg='white'){
  require(grid)
  theme_classic(...) +
    theme(rect=element_rect(fill=bg),
          axis.title.x=element_text(size=12),  # X axis title
          axis.title.y=element_text(size=12),  # Y axis title
          plot.margin=unit(c(2, 2, 1, 1), "cm"),
          panel.border=element_rect(fill='transparent', color='transparent'),
          panel.grid=element_blank(),
          axis.title = element_text(color='black', vjust=0.1),
          axis.ticks.length = unit(0.2,"lines"),
          axis.ticks = element_line(color='black'),
          axis.text.x=element_text(size=12,vjust=.5),  # X axis text
          axis.text.y=element_text(size=12), 
          legend.title=element_blank(),
          legend.key=element_rect(fill='transparent', color='transparent'))
}
library(ggplot2)
# Function definition from SO:
remove_geom <- function(ggplot2_object, geom_type) {
  # Delete layers that match the requested type.
  layers <- lapply(ggplot2_object$layers, function(x) {
    if (class(x$geom)[1] == geom_type) {
      NULL
    } else {
      x
    }
  })
  # Delete the unwanted layers.
  layers <- layers[!sapply(layers, is.null)]
  ggplot2_object$layers <- layers
  ggplot2_object
}


temp_all$Percent2=1-temp_all$Percent
p=ggwithinstats(
  data  = temp_all,
  x     = Group,
  y     = Percent2,  
  type = "p",
  effsize.type = "g", 
  fill=Group,
  #plot.type="box", 
  mean.plotting = FALSE, 
  violin.args = list(width = 0, alpha = 0.2, na.rm = TRUE,linewidth = 0),
  boxplot.args = list(width = 0.4),
  #pairwise.display="all",
  p.adjust.method = "none",
  results.subtitle = T,
  centrality.plotting=F,
  plot.type = "box",
)+theme(text = element_text(size = 10))+theme_classic()+
  ylab(label = "Percent of microbiome genome")+
  xlab("")
p
extract_stats(p)
remove_geom(p, "GeomViolin")

ggsave("Figure2-250201.pdf",height = 6,width = 5)


ggwithinstats(
  data  = temp_all,
  x     = Group,
  y     = Percent2,  
  type = "p",
  effsize.type = "g")

