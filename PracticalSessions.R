# Create 2 vectors called “x” and “y”.
x <- c(3, 12, 7)
y <- c(4, 9, 11)

# Add each element of x to each element of y.
z <- x + y
z

# add the number 2 to each element of x, and 50 to each element of y.
x <- x + 2
x
y <- y + 50
y

# Using the SUM() command, find the sum of vector x.
# Using the MEAN() command, find the mean of vector y.
sum(x)
mean(y)

# Create a new vector called w and store 2, 7, NA, 20 into it.
w <- c(2, 7, NA, 20)

# Check the SUM() of w. 
sum(w)
sum(w, na.rm=TRUE)

# Check the type of vector v.
v <-  w[!is.na(w)]
typeof(v)

# Using the > operator, check to see if each element in x is greater than each element in y.
x > y

# Using the append() function, add the number 12 to vector x.
x <- append(x, 12)
x

# Create a vector called u that contains the numbers 5 to 20 inclusive
u <- 5:20

# add the letters f to j inclusive to vector u using append().
letters_to_add <- letters[6:10]
u <- append(u, letters_to_add)
u
