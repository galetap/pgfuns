#' @export

# PG function for import and export dataframe from clipboard

im <- function(...){
  read.delim("clipboard", dec = ",", na.strings = "", ...) %>%
    as_tibble()
}
