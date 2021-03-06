#' @title knife edge ogive
#' 
#' @description 
#' A method to simulate a knife edge ogive where at a given age the proportion chnages from 0 to 1
#' 
#' @import FLCore 
#' @import ggplotFL

#' 
#' @param age FLQuant, FLPar or numeric with ages 
#' @param params \code{FLPar}
#' @param ... any other arguments
#' 
#' @aliases knife knife-method knife,FLQuant,FLPar-method knife,FLPar,FLPar-method knife,numeric,numeric-method knife,FLQuant,numeric-method
#' @return returns an object of same type as \code{age} e.g. \code{FLQuant}
#' 
#' @seealso \code{\link{sigmoid}},  \code{\link{dnormal}}, \code{\link{logistic}}
#' 
#' @exportMethod knife
#' @docType methods
#' @rdname knife
#' 
#' @details
#' The knife ogive is an S-shaped or knife curve or knifeal functions, 
#' Verhulst hypothesizes that small populations increase geometrically, because the supply of 
#' resources exceeds demand. Then, as supply and demand balance, population growth is constant. 
#' Finally, as demand exceeds supply, population growth decreases at the same rate that it had 
#' increased. Verhulst describes this process with an equation that enables him to predict when 
#' a population will reach any given size (see Verhulst's Figure):
#' 
#' @examples
#' \dontrun{
#' params=FLPar(a1=4)
#' age=FLQuant(1:10,dimnames=list(age=1:10))
#' knife(age,params)
#' }
setMethod("knife", signature(age="FLQuant",params="FLPar"),
          function(age,params,...){   
            res=knifeFn(age,params)
            res@units=""
            res})
setMethod("knife", signature(age="FLPar",params="FLPar"),
          function(age,params,...){   
            res=knifeFn(age,params)
            res@units=""
            res})
setMethod("knife", signature(age="numeric",params="numeric"),
          function(age,params,...) 
            knifeFn(age,params))
setMethod("knife", signature(age="FLQuant",params="numeric"),
          function(age,params,...) { 
            res=knifeFn(FLPar(params),age)
            res@units=""
            res})

knifeFn<-function(age,par){
    res=age
    
    res[age>=c(par["a1"])][]=1
    res[age< c(par["a1"])][]=0
    
    return(res)}
