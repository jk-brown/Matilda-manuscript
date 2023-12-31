# 1 Load Libraries --------------------------------------------------------

library(ggplot2)

# 2 Produce sample data to plot -------------------------------------------

# Producing random score values for the figure
set.seed(100)
data <- data.frame(x = runif(600, min = 1, max = 20),
                   y = runif(600, min = 1, max = 20))

# Initialize scores object
scores <- numeric(length(data$x))

# Writing a loop to compute scores based on score_ramp() from matilda.
for (i in data) {
  
  # compute abs differences for each index in `data`
  Differences <- abs(data$x - data$y)
  
  # define scores when differences are greater than or less than the cut off 
  # values of min = 5 and max = 10
  scores [Differences >= 10] <- 0
  scores [Differences <= 5] <- 1
  
  # define and compute how to deal with values between 5-10
  between_w1_w2 <- Differences > 5 & Differences < 10
  w1_w2_frac <- (Differences [between_w1_w2] - 5) / (10 - 5)

  # scores are one minus the fraction computed above.
  scores [between_w1_w2] <- 1 - w1_w2_frac
  
 return(scores)
  
  }

# add column of differences and a column of scores
data$Differences <- abs(data$x - data$y)
data$Score <- scores


# 3 Plot score_ramp example  ----------------------------------------------

score_ramp <- ggplot(data = data, aes(x = Differences, y = Score)) +
  geom_line(color = "dodgerblue",
            linewidth = 1) +
  labs(x = "Absolute Difference") +
  theme_light()
score_ramp

# save figure
ggsave("figures/figure_03.tiff",
       plot = score_ramp,
       device = "tiff",
       width = 10,
       height = 10,
       units = c("cm"),
       dpi = 300)
