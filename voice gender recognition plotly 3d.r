i <- 1  # Initialize 'i' with a -value, for example, 1
options(repos = c(CRAN = "https://cran.r-project.org"))

# Now you can install packages from the specified CRAN mirror
i
install.packages("plotly")
install.packages("caret")
install.packages("e1071")

library(plotly)
library(caret)

library(e1071)

install.packages("plotly")
library(plotly)


set.seed(42)
num_samples <- 100
feature1 <- rnorm(num_samples, mean = 50, sd = 10)
feature2 <- rnorm(num_samples, mean = 60, sd = 15)
feature3 <- rnorm(num_samples, mean = 70, sd = 12)
gender <- sample(c("Male", "Female"), num_samples, replace = TRUE)


data <- data.frame(feature1, feature2, feature3, gender)


plot <- plot_ly(data = data, x = ~feature1, y = ~feature2, z = ~feature3, color = ~gender,
                colors = c("blue", "pink"), marker = list(size = 8),
                text = ~paste("Gender: ", gender)) %>%
  add_markers()


plot <- plot %>% layout(scene = list(xaxis_title = "Feature 1",
                                     yaxis_title = "Feature 2",
                                     zaxis_title = "Feature 3"))


plot

