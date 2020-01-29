library(tidyverse)
library(janitor)
library(lubridate)


# to pick back up where we left off, let's load back our cleaned 'employee' data
employees <- read_rds("data/cleaned/employees.rds")


# step 1: uniquely identify rows --------------------------------------------------

# to understand your data well, you want to know what variable, or combination of variables,
# can be used to uniquely identify each row.

# generally, we know the employees data has one row per employee per year. 
# but specifically, what variables can we use to identify each unique employee/year?

employees %>% nrow()
employees %>% select(uniqueid) %>% n_distinct()
employees %>% select(year,uniqueid) %>% n_distinct()

employees %>% 
  group_by(year,uniqueid) %>% 
  filter(n()>1) %>% 
  View()

# this is just one way to remove duplicates, and is specific to our situation,
# where we don't care which of the duplicates we keep.
employees_deduped <- employees %>% 
  group_by(year,uniqueid) %>% 
  filter(row_number()==1) %>% 
  ungroup()

employees_deduped %>% nrow()



# step 2: join two datasets! --------------------------------------------------------------

# let's read in data on active warrants from the city court
# read more about the data here: https://data.brla.gov/Public-Safety/City-Court-Warrants/3j5u-jyar 
warrants <- read_csv("data/raw/baton_rouge/warrants_2020.01.27_18.45.30.csv") %>% clean_names() 

# make a new object called employees_2019 that has only 2019 data
employees_2019 <- employees %>% filter(year==2019)

head(warrants$name)
head(employees_2019$full_name)

# join the two to find the overlap
overlap <- inner_join(
  warrants,
  employees_2019,
  by=c("name"="full_name")
)


# case_when() is a helpful function for recoding values.
overlap <- overlap %>% 
  mutate(
    case_type_desc = case_when(
      case_type=="CMISD" ~ "Criminal Misdemeanor", 
      case_type=="DV" ~ "Domestic Violence", 
      case_type=="CCTRAF" ~ "Traffic Offense", 
      case_type=="PP" ~ "Partial Payment Account", 
      case_type=="CCDWI" ~ "Driving While Intoxicated",
      TRUE ~ "other"
    )
  )


overlap %>% count(case_type,case_type_desc)

overlap %>% filter(case_type_desc %in% c("Driving While Intoxicated","Domestic Violence")) %>% View()
