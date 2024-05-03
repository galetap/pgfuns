#' @export

# Funkce pro vypocet standard error pro odds ratio u logisticke regrese
# Problem je, ze tidy(logitmodel, exponentiate = T) vypisuje SE pro linearni koeficient
# SE je tedy stejne jako u tidy(logitmodel)

# Funkce se_or to resi

# https://www.andrewheiss.com/blog/2016/04/25/convert-logistic-regression-standard-errors-to-odds-ratios-with-r/

se_or <- function(model = logitmodel){
  tidy(logitmodel, exponentiate = F, conf.int = T) %>% 
    mutate(OR = exp(estimate),  # Odds ratio
           var.diag = diag(vcov(logitmodel)),  # Variance of each coefficient
           se.diag = sqrt(var.diag),
           SE_OR = sqrt(OR^2 * var.diag)) %>% 
    select(term, OR, SE_OR, starts_with("conf"), statistic, p.value)
}
