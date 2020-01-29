# for now, don't worry about this part
library(tidyverse)
USArrests <- USArrests %>% 
  rownames_to_column(var = "state")

# look at the data
View(USArrests)

# This data set contains statistics, in arrests per 100,000 residents for assault, murder, and rape in each of the 50 US states in 1973. Also given is the percent of the population living in urban areas.
# Murder 	 Murder arrests (per 100,000)
# Assault  Assault arrests (per 100,000)
# UrbanPop Percent urban population
# Rape 	 	 Rape arrests (per 100,000) 


ggplot(data=USArrests, aes(x=Assault,y=Murder)) +
  geom_point() +
  labs(x="Assault Arrests (per 100,000 people)",y="Murder Arrests (per 100,000 people)") +
  geom_smooth(method="lm") +
  theme_minimal()


ggplot(data=USArrests, aes(x=reorder(state,Murder),y=Murder)) +
  geom_col() +
  labs(x=NULL,y=NULL,title="Murder Arrests in 1973",subtitle="per 100,000 people") +
  coord_flip() +
  theme_minimal()




