library(waffle)
parts <- c(75, 25)
waffle(parts, rows = 8)
# Create a vector named test2 with two elements: `Host` and `Pathogen`.
# The element `Host` has a value of 75, and the element `Pathogen` has a value of 25.
test2 <- c(`Host` = 75, `Pathogen` = 25)
colors=c("#ffa69e","#93e1d8")
waffle::waffle(test2, colors = colors,
               rows = 6)
