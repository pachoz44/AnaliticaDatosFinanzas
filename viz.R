library(tidyverse)
library(palmerpenguins)

#crea histograma
penguins %>%
  ggplot(aes(x= bill_depth_mm)) +
  geom_histogram()

# hi there the path in OS is:
# C:\R\UniversidadAndes
