# 1
ufo_data <- read_csv("ufo.csv")
str(ufo_data)
head(ufo_data, 15)
nrow(ufo_data)

# 2
ufo_data$datetime <- as.Date(ufo_data$datetime, format = "%m/%d/%Y")
class(ufo_data$datetime)

# 3
str(ufo_data)

#4
names(ufo_data)
names(ufo_data)[names(ufo_data) == "duration (seconds)"] <- "DurationSeconds"
names(ufo_data)[names(ufo_data) == "duration (hours/min)"] <- "DurationHrsMins"
names(ufo_data)[names(ufo_data) == "date posted"] <- "DatePosted"
names(ufo_data)

# 5
ufo_data$latitude <- as.numeric(ufo_data$latitude)
str(ufo_data)

# 6
library(mice)
library(VIM)
missing_data <- is.na(ufo_data)
aggr(ufo_data, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE, labels=names(ufo_data))
png("missingvars.png")
dev.off()


# 8
# sort ufo_data by shape and then by city
sorted_ufo_data <- ufo_data[order(ufo_data$shape, ufo_data$city), ]

# extract datetime, city, country, and shape columns
sorted_ufo_data <- sorted_ufo_data[, c("datetime", "city", "country", "shape")]

# display first 15 rows of sorted_ufo_data
head(sorted_ufo_data, 15)

# show structure of sorted_ufo_data
str(sorted_ufo_data)


# 9
# subset the data frame to include only records where country is "gb" and shape is "disk"
ufo_gb_disk <- subset(ufo_data, country == "gb" & shape == "disk")
# count the number of records in the new data frame
num_records <- nrow(ufo_gb_disk)
# display the number of records in ufo_gb_disk
num_records

# 10
# save modified_ufo.csv
write.csv(ufo_data, file = "modified_ufo.csv", row.names = FALSE)

# save ufo_gb.csv
write.csv(ufo_gb_disk, file = "ufo_gb.csv", row.names = FALSE)

# save sorted_ufo.csv
write.csv(sorted_ufo_data, file = "sorted_ufo.csv", row.names = FALSE)


