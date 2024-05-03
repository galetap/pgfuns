#' @export


# theme_PG_VZFF pro VZFF

theme_PG_VZFF <- 
  function (theme = theme_PG()) {
    theme + 
      theme(legend.position = "bottom",
            legend.direction = "horizontal",
            strip.background.x = element_rect(colour="grey33", fill="white"),
            strip.background.y = element_rect(colour="white", fill="white"),
            strip.text.x = element_text(hjust = 0.05),
            strip.text.y = element_text(size = 8, angle = 0),
            panel.spacing.y=unit(1, "lines"),
            strip.text = element_text(hjust = 0, size = 9, face="bold"),
            plot.title = element_text(size = 9, face = "bold"),
            plot.subtitle = element_text(size = 9, hjust = 0,
                                         margin = margin(0, 0, 5, 0, unit = "pt")),
            plot.caption = element_text(size = 7, hjust = 1),
            panel.grid.major.x = element_line(linetype = 3, color = "gray66"),
            panel.grid.major.y = element_blank())
  }
