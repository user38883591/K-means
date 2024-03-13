#Raster Data Handling and Classification

library(raster)
#Setting working directory
setwd("C:/Users/colloh/Desktop/aa/Lesson2/data")

#See what is in the directory

dir()
ndvi <- raster("C:/Users/colloh/Desktop/aa/Lesson2/data/ndvi.tif")

# Plotting NDVI
plot(ndvi, main = "NDVI of Nairobi")

# Reclassification using Thresholding
#.....................................
#Defining reclassification classes

classes<- c(-Inf,0.25, 1, 0.25,0.3, 2, 0.3, 0.4, 3, 0.4, 0.5, 4, 0.5, Inf, 5)

#Implementing reclassication
vegc <-reclassify(ndvi, classes)

#Plot reclassified raster
plot(vegc, col = rev(terrain.colors(5)), main = "NDVI-based thresholding")

#Unsupervised Classification Using Kmeans Clustering
#-----------------------------------------

#Convert the raster values into a vector
nr <- getValues(ndvi)

summary(nr)

#Set seed because "kmeans" initiate centers in random location
set.seed(99)

nr_na<- na.omit(nr)

kmNDVI <- kmeans(nr_na, centers = 5, iter.max = 500, nstart = 5)


kmNDVIRast <-setValues(ndvi, kmNDVI$cluster)

# Plot Kmeans result
plot(kmNDVIRast, col = rev(terrain.colors(5)), main = "NDVI Kmean Cluster")

#Defining colors for plotting
myColors <- c("lightgrey", "darkgreen", "orange", "yellow", "green")

par(mfrow = c(1,3))

plot(ndvi, main="NDVI")
plot(vegc, col = rev(terrain.colors(5)), main = "Thresholding")
plot(kmNDVIRast, col= myColors, main= "Kmeans")

