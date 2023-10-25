pattern <- "worldpop"
worldpop <- st_read(
  paste0("data/mapme_biodiversity/", pattern, "/tileindex_", pattern, ".gpkg")
)

pattern2 <- "nelson_et_al"
nelson <- st_read(
  paste0("data/mapme_biodiversity/", pattern2, "/tileindex_", pattern2, ".gpkg")
)

update_tileindex <- function(pattern) {
  # Construct the file path based on the provided pattern
  file_path <- paste0("data/mapme_biodiversity/", pattern, "/tileindex_", pattern, ".gpkg")
  
  # Read the geospatial data from the file
  data <- st_read(file_path)
  
  # Modify the location column
  data <- data %>%
    mutate(location = str_replace(location, "C:/Users/fbede/Documents/Statistiques/", 
                                  "/home/onyxia/work/"))
  
  # Remove the original file
  file.remove(file_path)
  
  # Write the updated data back to the file
  st_write(data, file_path, replace = TRUE)
  
  cat("File updated successfully!\n")
}

# Example of usage
update_tileindex("worldpop")
