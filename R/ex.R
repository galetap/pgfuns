#' @export

# PG function for import and export dataframe to clipboard

ex <- function(df, size = 64, ...) {
  write.table(df, file = paste("clipboard-", size, sep = ""),
              sep="\t", dec = ",", col.names = NA, na = "")
}

