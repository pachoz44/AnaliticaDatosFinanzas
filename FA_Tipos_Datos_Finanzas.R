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
