library(tidyverse)
library(aws.s3)

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

# Listing files in bucket
my_files <- get_bucket_df(bucket = "fbedecarrats",
                          prefix = "data_processed",
                          region = "") %>%
  pluck("Key")

my_local_files <- list.files("data/mapme_biodiversity/worldpop", full.names = TRUE, recursive = TRUE)

my_files_dest <- paste0("diffusion/cours_tana/", my_local_files)

map2(my_local_files, my_files_dest, put_to_s3)

put_to_s3(from = "data/carte_mailles.png",
          to = "diffusion/cours_tana/data/carte_mailles.png")

copy_object(from = "diffusion/deforestation_madagascar/data_s3/ch3",
            from_bucket = ,
            to = "diffusion/cours_tana/data/carte_mailles.png",
            to_bucket = )
