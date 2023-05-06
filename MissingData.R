# This script builds the managers dataset
# and populates it with data
# Refer to the notes on Blackboard for further information
# on this practical

# Load data from previous session
column_names <- c("Date", "Country", "Gender", "Age", "Q1", "Q2", "Q3", "Q4", "Q5")

# Enter data into vectors before constructing the data frame
date_col <- c("2018-15-10", "2018-01-11", "2018-21-10", "2018-28-10", "2018-01-05")
country_col <- c("US", "US", "IRL", "IRL", "IRL")
gender_col <- c("M", "F", "F", "M", "F")
age_col <- c(32, 45, 25, 39, 99) # 99 is one of the values in the age attribute - will require recoding
q1_col <- c(5, 3, 3, 3, 2)
q2_col <- c(4, 5, 5, 3, 2)
q3_col <- c(5, 2, 5, 4, 1)
q4_col <- c(5, 5, 5, NA, 2) # NA is inserted in place of the missing data for this attribute
q5_col <- c(5, 5, 2, NA, 1)

# Construct a data frame using the data from all vectors above
managers_data <- data.frame(date_col, 
                            country_col, 
                            gender_col, 
                            age_col, 
                            q1_col, 
                            q2_col, 
                            q3_col, 
                            q4_col, 
                            q5_col)

# Add column names to data frame using column_names vector
colnames(managers_data) <- column_names

# Recode the incorrect 'age' data to NA
managers_data$Age[managers_data$Age == 99] <- NA

# Create a new attribute called AgeCat and set valuess
# in AgeCat to the following if true:
# <= 25 = Young
# >= 26 & <= 44 = Middle Aged
# >= 45 = Elderly
# We will also recode age 'NA' to Elder

managers_data$AgeCat[managers_data$Age >= 45] <- "Elder"
managers_data$AgeCat[managers_data$Age >= 26 & managers_data$Age <= 44] <- "Middle Aged"
managers_data$AgeCat[managers_data$Age <= 25] <- "Young"
managers_data$AgeCat[is.na(managers_data$Age)] <- "Elder"

# Recode AgeCat so that is ordinal and factored with the
# order Young, Middle aged, Elder
# We'll store the ordinal factored data in variable 'AgeCat'
AgeCat <- factor(managers_data$AgeCat, order = TRUE, levels = c("Young", "Middle Aged", "Elder"))

# Replace managers's AgeCat attribute with newly ordinal foctored data
managers_data$AgeCat <- AgeCat

# Create a new column called 'summary_col' that
# contains a summary of each row
summary_col <- managers_data$Q1 + managers_data$Q2 + managers_data$Q3 + managers_data$Q4 + managers_data$Q5
summary_col

# Add summary_col to the end of the data frame
managers_data <- data.frame(managers_data, summary_col)


# Calculate mean value for each row
mean_value <- rowMeans(managers_data[5:9])

# Add mean_value to end of managers data frame
managers_data <- data.frame(managers_data, mean_value)

# Show data frame contents
managers_data

# Change the name of this column to "mean value"
names(managers_data)[12] <- "mean value"

# Change name of summary_col to "Answer total"
names(managers_data)[11] <- "Answer total"

# Show 
str(managers_data)

# Show a summary for the numerical values
# It isnt possible to summarise a column
# where NA is present so I've removed NA values 
# using "na.rm = TRUE"
# Selected columns are listed inside a vector
# Note the "," inside the square brackets 
# which indicates I am working on columns and not rows
column_summary <- colSums(managers_data[, c(4:9,11:12)], na.rm = TRUE)
column_summary
# This row cannot be added to the data frame as there are missing 
# values for some columns, and the row must match the data frame 
# structure

# listwise deletion
new_data <- na.omit(managers_data)
new_data

# Use the complete cases
complete_data <- complete.cases(managers_data)
complete_data

# Show the number of complete rows 
sum(complete_data)

# Shoow the number of missing rows
sum(!complete_data)

# List the data that does not have missing values
complete_data <- managers_data[complete.cases(managers_data),]
complete_data

# Find sum of the missing values in the age attribute
sum(is.na(managers_data$Age))

# Find the mean of the missing values in the age attribute
mean(is.na(managers_data$Age))

install.packages("mice")
library(mice)
md.pattern(managers_data)

install.packages("VIM")
library(VIM)
missing_values <- aggr(managers_data, prop = FALSE, numbers = TRUE)

summary(missing_values)

matrixplot(managers_data)


# Extract age and Q1 from managers data
# create vector of what we want to extract
# Then use indexer to extract them

names(managers_data)
include_list <- names(managers_data) %in% c("Age", "Q1")
include_list
new_data <- managers_data[include_list]
new_data

new_data <- subset(managers_data, select = c("Age", "Q1"))
new_data

# Extract all records where age >35 or age < 24 and only list gender and age
attach(managers_data)
new_data <- subset(managers_data, Age > 35 | Age < 24, select = c("Gender", "Age"))
new_data
