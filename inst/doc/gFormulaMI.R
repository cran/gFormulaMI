## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(gFormulaMI)

## -----------------------------------------------------------------------------
head(simDataFullyObs)

## -----------------------------------------------------------------------------
set.seed(7626)
#impute synthetic datasets under two regimes of interest
imps <- gFormulaImpute(data=simDataFullyObs,M=10,trtVars=c("a0","a1","a2"),
                        trtRegimes=list(c(0,0,0),c(1,1,1)))

## -----------------------------------------------------------------------------
head(mice::complete(imps))

## -----------------------------------------------------------------------------
fits <- with(imps, lm(y~factor(regime)))

## -----------------------------------------------------------------------------
syntheticPool(fits)

## -----------------------------------------------------------------------------
simDataMissing <- simDataFullyObs
simDataMissing$l0[runif(nrow(simDataMissing))<0.2] <- NA
simDataMissing$l1[runif(nrow(simDataMissing))<0.2] <- NA
simDataMissing$l2[runif(nrow(simDataMissing))<0.2] <- NA
simDataMissing$y[runif(nrow(simDataMissing))<0.2] <- NA

## -----------------------------------------------------------------------------
simDataMissingImps <- mice::mice(simDataMissing,m=10,printFlag=FALSE)

## -----------------------------------------------------------------------------
imps2 <- gFormulaImpute(data=simDataMissingImps,M=20,trtVars=c("a0","a1","a2"),
                        trtRegimes=list(c(0,0,0),c(1,1,1)))

