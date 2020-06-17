#  Quiz 1 Cleaning and Extracting data 

PATH <- '/Users/Shrey/Desktop/Data Science JHU/Quiz1---Cleaning-and-Extracting-Data/'
# ---- Question 1 ----
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

# and load the data into R. The code book, describing the variable names is here:
  
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

# How many properties are worth $1,000,000 or more?

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv','/Users/Shrey/Desktop/Data Science JHU/Quiz1---Cleaning-and-Extracting-Data/housing.csv')

data<-fread('housing.csv')

data[, .N,VAL==24] # To calculate frequency of variable VAL where value is 24



# --- Question 3 -----
#Download the Excel spreadsheet on Natural Gas Aquisition Program here:
  
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx

#Read rows 18-23 and columns 7-15 into R and assign the result to a variable called 'dat'

# install.package('readxl')

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx','/Users/Shrey/Desktop/Data Science JHU/Quiz1---Cleaning-and-Extracting-Data/question3.xlsx',method = 'curl')
library(readxl)

# Important way to read excel files below
dat<- xlsx::read.xlsx('question3.xlsx',sheetIndex = 1,rowIndex = 18:23,colIndex = 7:15)

sum(dat$Zip*dat$Ext,na.rm=T)

#  ----- Question 4 - Read the XML data on Baltimore restaurants from here: -----
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml

#  How many restaurants have zipcode 21231?
  
# Answer = 127

library(XML)

fileURL <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml' #Remove the 's' from https otherwise it will give error

doc <- xmlTreeParse(fileURL,useInternalNodes = TRUE)

rootNode <- xmlRoot(doc) #xmlRoot indicates the starting point of XML file

names(rootNode) # OUTPUT : Prints out first node - row

names(rootNode[[1]]) # OUTPUT : Prints all the sub nodes of the first node 'row'
# We notice that the sub nodes also have the node 'row' in them

xmlSApply(rootNode[[1]],xmlValue) # Similar to SApply function but for XML. Prints out the full details of each of the sub 'row' elements.

# To access elements of each of these sub 'row' nodes we do the following :
names(rootNode[[1]][[1]]) #OUTPUT : Elements that we need i.e. name, zipode, neighborhood, councildistrict ... etc.


# USING XPATH to access elements 

xpathSApply(rootNode[[1]][[1]],'//name',xmlValue) #This prints out names of all the rows in the xml file 

#We need zipcodes, therefore :

data <- xpathSApply(rootNode[[1]][[1]],'//zipcode',xmlValue) # The double slash '//' means sub node variable 

table(data==21231) # Number of true values is the required answer.





# ----- Question 5 -----
# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'

download.file(fileURL,'/Users/Shrey/Desktop/Data Science JHU/Quiz1---Cleaning-and-Extracting-Data/question5.csv')


library(data.table)

DT <- fread('question5.csv')

# Now use system.time(<expression in choices>) to calculate the fastest time