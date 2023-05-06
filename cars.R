cars_data <- mtcars
summary(cars_data)

hist(cars_data$mpg, col='steelblue',
     main='Frequency chart of data distribution of mpg')
hist(cars_data$wt, col='steelblue',
     main='Frequency chart of data distribution of wt')

# Q-Q plot can help to determine normality
qqnorm(cars_data$mpg)
qqline(mpg, col = "red")

qqnorm(cars_data$wt)
qqline(wt, col = "red")

normality_test <- shapiro.test(cars_data$mpg)
normality_test$p.value

normality_test <- shapiro.test(cars_data$wt)
normality_test$p.value

attach(cars_data)
tapply(mpg, wt, shapiro.test)
 # The data is normally distributed 

# Format of the test is Pearson’s Correlation Coefficient 
res <- cor.test(cars_data$wt, cars_data$mpg, 
                method = "pearson")
res

# p -value is 1.29^(-10) therefore we have sufficient proof to accept H1 
# Therefore mpg and wt are highly correlated








# Q4) H0= no relation btwn gear type and horsepower
#     H1 = relation btwn gear type btwn horsepower

# Independent variable: Type of gearbox (categorical variable, e.g. manual or automatic)
# Dependent variable: Horsepower (continuous variable)

# labels starts with what is assigned to lower value first
# eg 0 = automatic, 1 = manual
attach(cars_data)
cars_data$Transmission <- factor(cars_data$am, labels = c("automatic", "manual"))
hist(cars_data$mpg, col='steelblue',
     main='Frequency chart of data distribution of mpg')
library("lattice")
histogram(~hp | Transmission, 
          data = cars_data, 
          main = "Distribution of car data", 
          xlab = "Horsepower", 
          ylab = "Transmission")
detach(beavers_data)           

normality_test <- shapiro.test(cars_data$hp)
normality_test$p.value # Therefore, hp is not normally distributed

with(cars_data, tapply(hp, Transmission, shapiro.test))
# Therefore transmission is also not normally distributed

model <- aov(hp ~ Transmission, data = cars_data)
summary(model)
# Insufficient evidi=ence to believe h1 therefore h0 is true
# no relation btwn gear type and horsepower