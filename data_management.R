library(aws.s3)
library(tidyverse)


# A function to put data from local machine to S3
put_to_s3 <- function(from, to) {
  aws.s3::put_object(
    file = from,
    object = to,
    bucket = "fbedecarrats",
    region = "",
    multipart = TRUE)
}

# A function to iterate/vectorize copy
save_from_s3 <- function(from, to) {
  aws.s3::save_object(
    object = from,
    bucket = "fbedecarrats",
    file = to,
    overwrite = FALSE,
    region = "")
}

put_to_s3("data/AP_Vahatra2.rds", "diffusion/cours_tana/data/AP_Vahatra2.rds")

# Send all firms files to S3
firms_s3 <- get_bucket_df(bucket = "fbedecarrats", region = "",
                           prefix = "diffusion/mapme_biodiversity/nasa_firms") %>%
  filter(str_detect(Key, "gpkg")) %>%
  pluck("Key")

firms_dest <- str_replace(firms_s3, "diffusion/", "data/")

map2(firms_s3, firms_dest, save_from_s3)


# Send all firms files to S3
my_bucket <- get_bucket_df(bucket = "fbedecarrats", region = "")

firms_files <- list.files(path = "data/nasa_firms", recursive = TRUE,
                          full.names = TRUE)

firms_dest <- str_replace(firms_files, "data/", "mapme_biodiversity/")

map2(firms_files, firms_dest, put_to_s3)


# Check which SRTM overlap with MAdagascar --------------------------------

overlaps_with_mada <- function(raster_file, contour_mada) {
  # Load the raster file
  r <- terra::rast(raster_file)
  
  # Convert the raster extent to an sf object
  r_sf <- st_as_sfc(st_bbox(r))
  
  # Check if there's any intersection between the raster extent and contour_mada
  any(st_intersects(r_sf, contour_mada))
}


files <- list.files("data/mapme_biodiversity/nasa_srtm", 
                    pattern = ".*tif",
                    full.names = TRUE)

overlapping_files <- files[map_lgl(files, overlaps_with_mada, contour_mada = contour_mada)]
