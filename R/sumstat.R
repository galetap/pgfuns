#' @export

# Compute summary statistics (PG user defined function)

sumstat <- function(data, short=T, conf=0.95){
  if (is_grouped_df(data)) {
    res <- 
      data %>% 
      group_nest(.key = "Data") %>% 
      mutate(Data=map(.x = Data, 
                      .f = ~sumstat(data = ., short=short, conf=conf))) %>% 
      unnest(Data)
    return(res)
  } 
  data %>% 
    as_tibble() %>%
    select_if(is.numeric) %>% 
    pivot_longer(cols = everything(), names_to = "Var", values_to = "Val") %>% 
    mutate(Var=fct_inorder(Var)) %>% 
    group_nest(Var, .key = "Data") %>% 
    mutate(Desc=map(.x = Data, 
                    .f = ~.x %>% 
                      summarise(n=sum(!is.na(.x)),
                                Mean=mean(Val, na.rm=T),
                                Median=median(Val, na.rm=T),
                                SD=sd(Val, na.rm=T)))) %>%
    unnest(Desc) %>%
    mutate(SE= SD / sqrt(n),
           CI = abs(qt((1-conf)/2, n-1)*SE),
           Lwr=Mean-CI,
           Upr=Mean+CI) %>% 
    # Choose columns in results
    {if (short)
      select(., Var, Data, n, Mean, SD, Lwr, Upr)
      else
        select(., Var, Data, n, Mean, Median, SD, Lwr, Upr)} %>% 
    mutate(SW=ifelse(n>=3 & n<=5000, 
                     map(Data, ~shapiro_test(.x, Val)),
                     list(tibble(variable=NA, statistic=NA, p=NA)))) %>%
    unnest(SW) %>% 
    add_significance("p") %>% 
    rename(SW_stat=statistic, SW_p=p, Sig=p.signif) %>%
    select(-Data, -variable) 
}

