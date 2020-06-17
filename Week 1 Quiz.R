#  Quiz 1 Cleaning and Extracting data 

#  Question 4 - Read the XML data on Baltimore restaurants from here:
  
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


# ---- USING XPATH to access elements ---- 

xpathSApply(rootNode[[1]][[1]],'//name',xmlValue) #This prints out names of all the rows in the xml file 

#We need zipcodes, therefore :

data <- xpathSApply(rootNode[[1]][[1]],'//zipcode',xmlValue) # The double slash '//' means sub node variable 

table(data==21231) # Number of true values is the required answer.



