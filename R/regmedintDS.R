#'
#' @title Regression-based causal mediation analysis
#' @description This function is similar to R function \code{regmedint} from the 
#' \code{regmedint} package.
#' @details The function 'regmedint' is used for regression-based causal mediation
#' analysis as described in Valeri & VanderWeele 2013 and Valeri & VanderWeele 2015.
#' @param data a string character, the name of the data frame containing the 
#' relevant variables.
#' @param yvar a character vector of length 1. Outcome variable name. It should be
#' the time variable for survival outcomes.
#' @param avar a character vector of length 1. Treatment variable name.
#' @param mvar a character vector of length 1. Mediator variable name.
#' @param cvar a character vector of length > 0. Covariate names. Use NULL if
#' there is no covariate. However, this is a highly suspicious situation. Even if
#' avar is randomized, mvar is not. Thus, there should usually be some confounder(s)
#' to account for the common cause structure (confounding) between mvar and yvar. 
#' @param eventvar a character vector of length 1. Only required for survival outcome
#' regression models. Note that the coding is 1 for event and 0 for censoring, 
#' following the R survival package convention.
#' #@param a0 a numeric vector of length 1. Reference level of treatment variable that
#' #is considered "untreated" or "unexposed".
#' #@param a1 a numeric vector of length 1.
#' #@param m_cde a numeric vector of length 1. Mediator level at which controlled direct
#' #effect is evaluated at.
#' #@param c_cond a numeric vector of the same length as cvar. Covariate vector at which 
#' #conditional effects are evaluated at.
#' #@param mreg a character vector of length 1. Mediator regression type: "linear" or "logistic".
#' #@param yreg a character vector of length 1. Outcome regression type: "linear", "logistic", 
#' #"loglinear", "poisson", "negbin", "survCox", "survAFT_exp", or "survAFT_weibull".
#' @param interaction a logical vector of length 1. Default to TRUE. Whether to include a 
#' mediator-treatment interaction term in the outcome regression model.
#' @param casecontrol a logical vector of length 1. Default to FALSE. Whether data comes from
#' a case-control study.
#' @param na_omit a logical vector of length 1. Default to FALSE. Whether to use na.omit() function
#' in stats package to remove NAs in columns of interest before fitting the models.
#' @return a summary table of the object of class 'multimed'.
#' @author Demetris Avraam, for DataSHIELD Development Team
#' @export
#'
regmedintDS <- function(data, yvar, avar, mvar, cvar, eventvar,
                        interaction = TRUE, casecontrol = FALSE, na_omit = FALSE){
  
  data <- eval(parse(text=data), envir = parent.frame())
  
  #cvar <- unlist(strsplit(cvar.transmit, split=","))

  regmedint.out <- regmedint::regmedint(data=data, yvar=yvar, avar=avar, mvar=mvar, cvar=cvar, eventvar=eventvar,
                                        a0=0, a1=1, m_cde = 1, c_cond = 0.5, mreg = "logistic", yreg = "survAFT_weibull",
                                        interaction = interaction, casecontrol = casecontrol, na_omit=na_omit)
  
  out <- summary(regmedint.out)
  return(out)
  
}