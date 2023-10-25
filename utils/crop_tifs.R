library(raster)
crop_raster_to_polygon <- function(raster_file, polygon, output_file) {
  r <- raster(raster_file)
  cropped_r <- crop(r, extent(polygon))
  mask_r <- mask(cropped_r, polygon)
  writeRaster(mask_r, filename=output_file, format="GTiff", overwrite=TRUE)
}

# Directory containing TIFF files
tif_directory <- "data/mapme_biodiversity/nelson_et_al"

# List all TIFF files
tif_files <- list.files(tif_directory, pattern="\\.tif$", full.names=TRUE)

# Loop through each TIFF file and crop it
for (tif_file in tif_files) {
  crop_raster_to_polygon(tif_file, mada, tif_file)
}


