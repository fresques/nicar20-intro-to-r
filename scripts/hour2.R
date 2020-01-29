library(tidyverse)
library(janitor)
library(lubridate)
library(scales)


# let's start fresh by reimporting the data
employees <- read_csv("data/raw/baton_rouge/employee_salaries.csv") %>% clean_names()



# step 1: make new variables ----------------------------------------------

# use mutate() from the dplyr package to make new variables

employees <- employees %>% 
  mutate(
    ot_pay_pct = total_ot_pay/base_pay,    
    extra_pay_pct = (gross_pay-base_pay)/base_pay
  )

# let's see how it worked by looking at a few rows
employees %>% 
  select(last_name, base_pay, total_ot_pay, gross_pay, ot_pay_pct, extra_pay_pct)


# your turn! 
# use dplyr verbs (select, filter, arrange) to look at the employee who earned the most overtime pay in 2019


# look at the employee who earned the most overtime pay in 2019, as a percent of their base salary.




# step 2: dates -----------------------------------------------------------

str(employees)

# current_hire_date and employment_end_date both contain date information, but they're being stored as text strings ('chr')

# let's use the lubridate package to turn them into dates
# (lubridate is part of the tidyverse, tho you have to load the package separately)
employees <- employees %>% 
  mutate(
    current_hire_date_clean = mdy(current_hire_date),
    employment_end_date_clean = mdy(employment_end_date)
  )

employees %>% 
  select(year,last_name,current_hire_date,current_hire_date_clean,employment_end_date,employment_end_date_clean,employment_status) %>% 
  View()

str(employees)

# now we can actually sort on date variables

# your turn! 
# find the longest tenured library employee as of 2019





# step 3: strings ---------------------------------------------------------

# what if we want name in one variable, instead of separated into first and last?
# the stringr package (part of the tidyverse) is helpful for working with strings (like character variables)
# str_c() concatinates strings
employees <- employees %>% 
  mutate(
    full_name = str_c(last_name,first_name)
  )

employees %>% 
  select(last_name,first_name,full_name) 

# hummm. doesn't look quite right!
employees <- employees %>% 
  mutate(
    full_name = str_c(last_name,first_name,sep=", ")
  )

employees %>% 
  select(last_name,first_name,full_name) 



# step 4: summaraize ---------------------------------------------------------------

departments_2019 <- employees %>% 
  filter(year==2019) %>%
  group_by(year,department_name) %>% 
  summarize(
    employees = n(),
    base_pay=sum(base_pay),
    total_ot_pay=sum(total_ot_pay)
  ) %>% 
  mutate(
    ot_pay_pct = total_ot_pay/base_pay
  ) 




# step 5: visualize -------------------------------------------------------


# viz 1: let's look at how much each department spends on overtime
# bar graph starting point
ggplot(data=departments_2019, aes(x=department_name,y=ot_pay_pct)) +
  geom_col() 


# full featured final viz
# department_barchart <- departments_2019 %>%
# mutate(department_name=str_to_title(department_name)) %>%
# ggplot(aes(x=reorder(department_name,ot_pay_pct),y=ot_pay_pct)) +
# geom_col() +
# scale_y_continuous(labels=percent) +
# labs(x=NULL,y="Overtime Pay") +
# coord_flip() +
# theme_minimal()

# save it out as an image :)
ggsave(
  plot=department_barchart,
  filename="visualizations/department_barchart.jpeg"
)


# viz 2: distribution of salaries
# histogram starting point 
employees %>% 
  filter(year==2019) %>% 
  ggplot(aes(x=gross_pay)) +
  geom_histogram()

# your turn! can you make it look nicer?


# faceting
employees %>% 
  filter(year==2019 & department_name %in% c("POLICE DEPARTMENT","LIBRARY BOARD OF CONTROL","FIRE DEPARTMENT")) %>% 
  ggplot(aes(x=gross_pay)) +
  geom_histogram() +
  facet_grid(department_name~.)




# replicate with old data ----------------------------------------------------

# your turn!
# read in the file employee_salaries_legacy.csv and assign it to an object named employees_legacy

# what years are covered?

# can you calculate the overtime percentage for each department?

# can you recreate our barchart for 2008?






# step 7: save your data --------------------------------------------------

# this is helpful if you want to share your data with a coworker or pick back up later!

# save as csv
write_csv(employees, "data/cleaned/employees.csv")
# save as rds (R data format)
write_rds(employees, "data/cleaned/employees.rds")
# save the department-level summary we made
write_csv(departments_2019, "data/cleaned/departments_2019.csv")


