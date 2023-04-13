x <- 3
y <- 4
z <- x+y
print(z)


x <- 10
y <- 20
result <- y-x
print(result)

library(ggplot2)
ggplot(mtcars, aes(x = mpg, y = wt)) + geom_point() + ggtitle("Miles per gallon vs weight") + labs(y = "Weight", x = "Miles per gallon")

library(datasets)
data(iris)
View(iris)

unique(iris$Species)
