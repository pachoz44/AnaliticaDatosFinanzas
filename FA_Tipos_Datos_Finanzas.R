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


PyV <- merge.xts(AMZN, NFLX, IBM, SPY)
colnames(PyV) <- c("Amazon P.Cierre", "Amazon Vol", "Netflix P.Cierre", "Netflix Vol",
                   "IBM P.Cierre", "IBM Vol", "SP500 P.Cierre", "SP500 Vol")


Precios <- dygraph(PyV[,c(1,3,5,7)], main = "Precios de Amazon, Netflix, IMB y SP&500") %>%
  dyAxis("y", label = "Precios") %>%
  dyRangeSelector(dateWindow = c("2014-01-01", "2020-07-01"))%>%
  dyOptions(colors = RColorBrewer::brewer.pal(4, "Set1"))

Precios



