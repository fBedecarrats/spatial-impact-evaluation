# Directory containing TIFF files
tif_directory <- "data/mapme_biodiversity/worldpop"

# List all TIFF files
tif_files <- list.files(tif_directory, pattern="\\.tif$", full.names=TRUE)

# Loop through each TIFF file and crop it
for (tif_file in tif_files) {
  crop_raster_to_polygon(tif_file, madagascar, tif_file)
}