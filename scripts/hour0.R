# welcome to R!
# this is a script, saved as 'hour0.R' on your computer. it is just a simple text file.
# lines that start with # are comments. lines that don't start with # are code!


# code can be as simple as some arithmetic 
1+2

# try running the code on line 6. I recommend putting your cursor on line 6, then hit command + enter (mac) or ctrl + enter (windows)


# code can also involve using a *FUNCITON*, like in excel
sum(1,2)
# the things we put inside the function are called *ARGUMENTS*

# there's also something called an *OBJECT*
# each object has a name ('my_special_number') and something that it stores.
# in this case, our object my_special_number  just stores a single numeric value, 1
my_special_number <- 1

my_special_number

# you can use objects as arguments to functions
sum(my_special_number,2)

# RStudio will helpfully auto-complete function and object names for you!
# type 'my_' or 'sum' and see what happens


# do you see a popup? hit enter or tab to have RStudio fill in the rest


# function names and objects names are both case-sensitive
Sum(my_special_number,2)

MY_SPECIAL_NUMBER


# Objects can also store a dataset!
# In R, datasets can be stored in a few different formats, including 'matrix', table', 'tibble', 'data.table', and 'data.frame'
# For now, don't worry about it. You can generally treat them all the same.
class(HairEyeColor)
# HairEyeColor comes built-in with R, which is why it isn't listed in yoru environment

# Let's take a look at this data!
# we'll use the View function
View(HairEyeColor)
