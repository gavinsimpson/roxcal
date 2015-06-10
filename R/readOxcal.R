##' @title Read OxCAL output files
##'
##' @description TODO
##'
##' @details TODO
##'
##' @param x filename of the OxCAL \code{.js} file.
##'
##' @return a list
##'
##' @author Gavin L. Simpson
##'
##' @importFrom V8 new_context
`readOxcal` <- function(x) {
    c <- new_context()
    c$eval("ocd={}; calib={}")
    c$source(x)
    ocd <- c$get("ocd")
    calib <- c$get("calib")
    list(ocd = ocd, calib = calib)
}
