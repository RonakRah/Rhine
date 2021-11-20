library(ggplot2)
library(sf)
library(terra)
library(raster)
library(data.table)
library(ncdf4)
library(ncdf4.helpers)

# unziping the data
path <- "/Users/ronakrah/Desktop/R practice/practice3/"
unzip(paste0(path,"OneDrive_1_17-11-2021.zip"),
      exdir = paste0(path,"nc_data") )
unzip(paste0(path,"OneDrive_2_17-11-2021.zip"),
      exdir = paste0(path,"metadata_observed") )

files_nc <- list.files(paste0(path,"nc_data/"),
                    pattern = "*.nc",
                    full.names = TRUE)
files_meta <- list.files(paste0(path,"metadata_observed/"),
                    pattern = "*.txt",
                    full.names = TRUE)
# checking the nc data
pr_nc <- nc_open(files_nc[1])
nc.get.dim.axes(pr_nc)
time_series <- range(nc.get.time.series(pr_nc)) #1950-2100
nc.get.variable.list(pr_nc) #pr

pr_rast <- raster(files_nc[1])
tm_rast <- raster(files_nc[2])
dim(pr_rast) #3 dimentional
dim(tm_rast) #3 dimentional
plot(tm_rast[[1]])

# checking the meta data + observed one

precipitation_observ <- fread(files_meta[2], na.strings = '-9999')
temprature_observ <- fread(files_meta[3], na.strings = '-9999')

h