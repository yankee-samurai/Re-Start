library(datasets)
# Load Data
data(mtcars)
# View first 5 rows
head(mtcars, 5)

?mtcars

#load ggplot2 package
library(ggplot2)
# Create a scatterplot of displacement (disp) and miles per gallon (mpg)
ggplot(aes(x = disp, y  = mpg), data = mtcars) + geom_point() + ggtitle("Displacement vs Miles per Gallon") + labs(x = "Displacement", y = "Miles/Gallon")

# Make vs a factor
mtcars$vs <- as.factor(mtcars$vs)
# Create a boxplot of the distribution for v-shaped and in-line engines
ggplot(aes(x = vs, y = mpg), data = mtcars) + geom_boxplot(alpha = 0.3) + theme(legend.position = "none")

ggplot(aes(x = wt), data = mtcars) + geom_histogram(binwidth = 0.5)
