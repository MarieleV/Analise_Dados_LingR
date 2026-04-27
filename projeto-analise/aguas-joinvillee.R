
library(tidyverse)
library(readxl)
library(patchwork)

setwd("C:/Users/silva/Documents/Desafio Águas de Joinville")
arquivo1 <- read_excel("Arquivo1.xlsx")
arquivo2 <- read_excel("Arquivo2.xlsx")

base_consolidada <- inner_join(arquivo1, arquivo2,
                                by = c("Matricula", "HD.Instalado"))

# 4. Gráfico de dispersão (X-Y)
ggplot(data = base_consolidada, aes(x = Volume, y = IDM)) +
  geom_point(color = "steelblue", alpha = 0.6, size = 2) +
  geom_smooth(method = "lm", se = TRUE, color = "red", linetype = "dashed") +
  geom_point(data = subset(base_consolidada, Volume > 3000),
              aes(x = Volume, y = IDM), color = "red", size = 4, shape = 17) +
  theme_minimal() +
  labs(title = "Dispersão: Volume vs IDM",
        subtitle = paste("Correlação de Pearson:",
                        round(cor(base_consolidada$Volume,
                                  base_consolidada$IDM), 4)),
        x = "Volumetria Total (m³)",
        y = "IDM (%)")

# 5. Boxplots combinados para IDM e volumetria total
p1 <- ggplot(data = base_consolidada, aes(y = IDM)) +
  geom_boxplot(fill = "tomato", outlier.color = "red", outlier.size = 3) +
  theme_minimal() +
  labs(title = "Distribuição do IDM", y = "IDM (%)", x = "")

p2 <- ggplot(data = base_consolidada, aes(y = Volume)) +
  geom_boxplot(fill = "skyblue", outlier.color = "red", outlier.size = 3) +
  theme_minimal() +
  labs(title = "Distribuição da Volumetria", y = "Volume (m³)", x = "")

p1 + p2