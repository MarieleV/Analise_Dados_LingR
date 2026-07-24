<div align="center">

# Análise de Desempenho de Hidrômetros

**Desafio Técnico:** Integração, Análise Estatística e Análise Crítica de Dados

**Base de dados:** 50 registros &nbsp;|&nbsp; **Período:** 2017–2026 &nbsp;

</div>

---
<div align="center">
  
Este repositório apresenta os resultados de uma análise técnica realizada sobre a base de dados de hidrômetros disponibilizada em Excel.

</div>

O trabalho contempla:
- Integração de duas bases de dados
- Análise estatística descritiva das variáveis principais
- Análise crítica sobre o comportamento dos equipamentos em campo

### Variáveis Analisadas

| Variável | Descrição |
|---|---|
| **IDM (%)** | Índice de Desempenho Metrológico: expressa a precisão de medição do hidrômetro em relação a um padrão de referência |
| **Volume (m³)** | Volumetria Total: total de m³ registrados pelo equipamento desde sua instalação |

---

## Fontes de Dados

Dois arquivos em formato `.xlsx` foram disponibilizados:

- **`Arquivo1.xlsx`** - Colunas: `Matrícula`, `HD.Instalado`, `Data de Instalação`, `Volume`
- **`Arquivo2.xlsx`** - Colunas: `Matrícula`, `HD.Instalado`, `IDM`

### Integração das Bases

A integração foi realizada por meio de um **inner join** utilizando as colunas `Matrícula` e `HD.Instalado` como chaves compostas. Essa abordagem garante que apenas registros com correspondência exata em ambas as bases sejam incluídos na análise, eliminando entradas sem par.

### Ferramentas Utilizadas

- **Linguagem R** (v4.5.3) com os pacotes `tidyverse`, `readxl` e `patchwork`
- **RStudio** para desenvolvimento e visualização
- Funções de estatística descritiva e correlação de Pearson

---

## Resultados

### Estatísticas Descritivas

Base consolidada com 50 registros únicos:

<div align="center">

| Variável | Mínimo | Média | Máximo | Desvio Padrão |
|---|---|---|---|---|
| **IDM (%)** | 88,70 | 98,85 | 101,10 | 2,34 |
| **Volume (m³)** | 5 | 693,46 | 3.787 | 713,98 |

</div>

### Dispersão — Volume × IDM

O gráfico de dispersão foi construído para identificar visualmente a relação entre a volumetria acumulada e o IDM de cada hidrômetro. A linha de tendência evidencia a direção e força da correlação.

> **Resultado:** Correlação de Pearson = **-1,00**  
> O gráfico revela uma relação linear perfeitamente negativa: à medida que o volume acumulado aumenta, o IDM diminui sistematicamente, confirmando premissas técnicas de funcionamento dos medidores, indicando que o aumento do volume registrado impacta diretamente na redução do desempenho metrológico devido ao desgaste natural e ao tempo de uso do hidrômetro.

### Boxplots — IDM e Volumetria

Os boxplots foram desenvolvidos para visualizar a distribuição estatística das duas variáveis, destacando a mediana, os quartis e a presença de valores atípicos.

> **Resultado:**  
> - O boxplot do IDM revela que **75% dos hidrômetros apresentam IDM acima de 97,75%**, com um único outlier em 88,70%.  
> - O boxplot de volumetria apresenta distribuição assimétrica à direita, com mediana de **486,5 m³** e outlier em **3.787 m³**.  
> - Em ambos os casos, os valores que fogem do padrão pertencem ao **mesmo equipamento**.

---

## Análise Crítica

### Padrões Identificados

A análise revelou um padrão consistente e estatisticamente significativo: **hidrômetros com maior volume acumulado tendem a apresentar menor IDM**. Esse comportamento é esperado do ponto de vista metrológico, pois o desgaste mecânico dos componentes internos compromete gradualmente a precisão de medição do equipamento.

### Outliers e Inconsistências

Foi identificado um único registro com comportamento crítico, que se destaca simultaneamente nos dois boxplots e no gráfico de dispersão:

<div align="center">

| Matrícula | Hidrômetro | Volume (m³) | IDM (%) |
|---|---|---|---|
| **1203971-3** | **A21L060170** | **3.787** | **88,70** |
| 1203756-7 | A19L073882 | 2.243 | 93,77 |
| 1203968-3 | A18L731516 | 2.152 | 94,06 |
| 1203753-2 | A21L266357 | 1.777 | 95,29 |
| 1203851-2 | A21L264269 | 1.574 | 95,96 |
| 1203671-4 | A21L120897 | 1.467 | 96,31 |
| 1203702-8 | A20L169855 | 1.331 | 96,76 |

</div>

> **Nota:** A primeira linha corresponde ao outlier crítico identificado na análise.

O hidrômetro **A21L060170** (matrícula 1203971-3) apresenta o maior volume acumulado (3.787 m³) e o pior IDM da base (88,70%), configurando um caso de **submedição expressiva**. Em termos práticos, esse equipamento está deixando de registrar aproximadamente **11,3% do volume consumido**, gerando perda de receita.

### Há relação entre Volumetria e IDM?

> **Sim.** A correlação de Pearson calculada foi de **-1,00** (correlação negativa perfeita), indicando que toda a variação no IDM é explicada linearmente pela variação na volumetria acumulada.

---

## Conclusão

A integração das duas bases de dados foi realizada com sucesso por meio de **inner join** com chave composta (`Matrícula + HD.Instalado`), resultando em **50 registros consolidados** sem perdas de informação.

A análise estatística demonstrou que o conjunto de hidrômetros avaliado possui desempenho globalmente satisfatório:
- **IDM médio: 98,85%**
- **75% dos equipamentos acima de 97,75%**

Contudo, foi identificado **um caso crítico de submedição** (IDM = 88,70%) que requer intervenção imediata, além de um grupo de **6 equipamentos adicionais** com IDM entre 93% e 97% que merecem atenção preventiva.

A correlação fortemente negativa entre volumetria acumulada e IDM confirma que o **envelhecimento dos hidrômetros**, expresso pelo volume total medido, é o principal fator de deterioração metrológica. Essa relação pode ser utilizada como base para um **programa de substituição preditiva**, reduzindo perdas comerciais e garantindo a acurácia do faturamento.

