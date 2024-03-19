library(dygraphs)
library(xts)
library(quantmod)
library(dplyr)

options(warn = -1)

star <- format(as.Date("2014-01-01"), "%Y-%m-%d")
end <- format(as.Date("2020-07-01"), "%Y-%m-%d")

precios_volumenes <-  function(simbolo)
{
  datos <- getSymbols(simbolo, from = star, to = end, auto.assign = FALSE)
  datos <- na.omit(datos)
  datos <- datos[,4:5]
  assign(simbolo, datos, envir = .GlobalEnv)
  
}
  
precios_volumenes("AMZN")
precios_volumenes("NFLX")
precios_volumenes("IBM")
precios_volumenes("SPY")


###################### Series de Tiempo XTS

PyV <- merge.xts(AMZN, NFLX, IBM, SPY)
colnames(PyV) <- c("Amazon P.Cierre", "Amazon Vol", "Netflix P.Cierre", "Netflix Vol",
                   "IBM P.Cierre", "IBM Vol", "SP500 P.Cierre", "SP500 Vol")


Precios <- dygraph(PyV[,c(1,3,5,7)], main = "Precios de Amazon, Netflix, IMB y SP&500") %>%
  dyAxis("y", label = "Precios") %>%
  dyRangeSelector(dateWindow = c("2014-01-01", "2020-07-01"))%>%
  dyOptions(colors = RColorBrewer::brewer.pal(4, "Set1"))

Precios


#####################  Panel Data
library(dygraphs)
library(htmltools)

dy_graficos <- list(
  dygraphs::dygraph(PyV[, c(1,3,5,7)], main = "Precios de Amazon, Netflix, IMB y SP&500"),
  dygraphs::dygraph(PyV[, c(2,4,6,8)], main = "Volumenes de Amazon, Netflix, IMB y SP&500"))

htmltools::browsable(htmltools::tagList(dy_graficos))


################### Datos Tipo Transversales o Cross Sectional

AMZN_2014 <- subset(PyV[,1], index(PyV) >= "2014-01-01"& index(PyV)<="2014-12-31")
AMZN_2014[c(1:5, nrow(AMZN_2014))]

AMZN_2020 <- subset(PyV[,1], index(PyV) >= "2020-01-01"& index(PyV)<="2020-12-31")
AMZN_2020[c(1:5, nrow(AMZN_2020))]

# visualizamos copn histogramas
par(mfrow=c(2,1)) # divides el marco del grafico en 2 filas y 1 columna

hist(AMZN_2014, freq = FALSE, col = "yellow", border = "blue", main = "Densidades de los Precios de Amzn en 2014", xlab = "Precios Cierre")
lines(density(AMZN_2014), ldw=2, col="red")

hist(AMZN_2020, freq = FALSE, col = "blue", border = "blue", main = "Densidades de los Precios de Amzn en 2020", xlab = "Precios Cierre")
lines(density(AMZN_2020), ldw=2, col="red")









