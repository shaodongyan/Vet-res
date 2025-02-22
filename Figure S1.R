
setwd("/Users/R/carpet/Pathogen/")
## 加载必要的包
library(ggplot2)
library(dplyr)
library(readr)
library(patchwork)

# 读取 CSV 文件（请确保文件在工作目录下或指定正确的路径）
swab <- read_csv("swab.csv")
BALF <- read_csv("BALF.csv")
fulid <- read_csv("fluid.csv")

# 数据预处理：添加用于显示的标签列
# 当 Relative_abundance 为 0 时显示 "no detected"，否则显示实际数值
swab <- swab %>%
  mutate(label = ifelse(Relative_abundance == 0, "no detected", as.character(Relative_abundance)))
BALF <- BALF %>%
  mutate(label = ifelse(Relative_abundance == 0, "no detected", as.character(Relative_abundance)))
fulid <- fulid %>%
  mutate(label = ifelse(Relative_abundance == 0, "no detected", as.character(Relative_abundance)))

# 定义绘制热图的函数
plot_heatmap <- function(data, title_text) {
  ggplot(data, aes(x = Group, y = Species, fill = Relative_abundance)) +
    geom_tile(color = "white") +
    scale_fill_gradient(low = "white", high = "steelblue") +
    geom_text(aes(label = label), size = 3) +
    labs(title = title_text, x = "", y = "") +
    theme_minimal() +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1),
      plot.title = element_text(hjust = 0.5)
    )
}

# 分别绘制三个热图
p_swab <- plot_heatmap(swab, "Swab")
p_BALF <- plot_heatmap(BALF, "BALF")
p_fulid <- plot_heatmap(fulid, "Fulid")

# 使用 patchwork 进行拼接，并合并图例
combined_plot <- (p_swab + p_BALF + p_fulid) + 
  plot_layout(ncol = 1,nrow=3, guides = "collect") &
  theme(legend.position = "bottom")

# 显示合并后的图形
print(combined_plot)
combined_plot
ggsave("test.pdf")
