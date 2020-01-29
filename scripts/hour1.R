
# step 0: load packages ---------------------------------------------------


# when you use a package on a computer for the first time, you need to install it
# install.packages("tidyverse")
# for this class, the packages we need should already be installed

library(tidyverse)
library(janitor)
library(lubridate)




# step 1: read in data ----------------------------------------------------

# read_csv() is from the readr package, which is part of the tidyverse
employees <- read_csv("data/raw/baton_rouge/employee_salaries.csv")

# FYI, this data is from https://data.brla.gov/Government/City-Parish-Employee-Annual-Salaries/g9vh-zeiw 


# your turn!  
# read in the file employee_salaries_legacy.csv and assign it to an object named employees_legacy
# FYI, this data is from https://data.brla.gov/Government/Legacy-City-Parish-Employee-Annual-Salaries/g5c2-myyj




# step 2: what's this data?! ----------------------------------------------

# there are several helpful functions to explore the data we just loaded in
colnames(employees)

str(employees)

dim(employees)

nrow(employees)

head(employees)

employees

# bonus: what did we use in hour0 to open up that nice interactive viewer?



# step 3: clean column names ----------------------------------------------

# Some of our columns are named things like `LAST NAME`
# R will technically allow it, but column names with spaces in them are VERY annoying to work with.
# let's use clean_names() from the janitor package to make the column names prettier. (replace spaces with _, make lowercase)

employees <- employees %>% clean_names()

# %>% is called a 'pipe' in the tidyverse. 
# (not the same as a pipe like this |)
# it lets you chain together operations and functions
# if you're reading code outloud, think of it as saying 'then'

# get help with a function right inside RStudio
?clean_names
?colnames

# your turn! 
# look at the column names now, to see how they've changed.





# step 4: pivot tables ---------------------------------------------------

# a great way to explore your data, especially columns without too many different values, is the count() function 
# it's pretty similar to pivot tables in excel, if you're familiar with that.

employees %>% count(year)


# your turn! 
# what departments are on the data?



# you can specify the sort order that count() uses
employees %>% count(department_number,sort=TRUE)
# you can also tell it to show you all rows
employees %>% count(department_number,sort=TRUE) %>% print(n=Inf)
# and you can get counts for combinations of 2+ variables
employees %>% count(department_number,department_name,sort=TRUE) %>% print(n=Inf)





# step 5: explore data with dplyr verbs -----------------------------------

# these functions are all from the dplyr package, which is part of the tidyverse


# there are 39 variables on our data! sometimes we only want to look at some of them.
# select() lets you pick out just some variables
employees %>% select(year, last_name, first_name, department_name, base_pay)


# let's find the employee with the lowest base salary :(
# arrange() sets the order of rows. (like 'sort' in excel.) 
# pass arrange() the variable you want to order by.
employees %>% arrange(base_pay)

# we can chain on a View() if that's nicer to look at.
employees %>% arrange(base_pay) %>% View()

# or chain on a select()
employees %>% 
  arrange(base_pay) %>%
  select(year, last_name, first_name, department_name, base_pay)

# your turn! arrange by last name


# by default arrange orders ascending, but you can also arrange descending
employees %>% 
  arrange(desc(base_pay)) %>%
  select(year, last_name, first_name, department_name, base_pay)

# and you can order by multiple variables
employees %>% 
  arrange(last_name, first_name) %>%
  select(year, last_name, first_name, department_name, base_pay)



# finally, you can chose only to keep some rows, using filter()
# keep just 2019!
employees %>% 
  filter(year==2019) %>% 
  arrange(last_name, first_name) %>%
  select(year, last_name, first_name, department_name, base_pay)

# keep just 2019, for people with last name Jones
employees %>% 
  filter(year==2019 & last_name=="JONES") %>% 
  arrange(last_name, first_name) %>%
  select(year, last_name, first_name, department_name, base_pay)


# your turn! keep just employees of the police department in 2019


# your turn! use filter() and count() look at what job titles exist in the police department, in 2019





