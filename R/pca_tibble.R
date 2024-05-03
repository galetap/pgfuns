#' @export

# PG function for formatting tables from PCA library factoextra
# Convert matrix to tibble with rownames in the column rowname

pca_tibble <- function(model=PCAmodel){
  model %>% 
    as.data.frame() %>%
    rownames_to_column() %>% 
    as_tibble()
}
