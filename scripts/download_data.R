library(downloader)

# source: https://data.brla.gov/Government/City-Parish-Employee-Annual-Salaries/g9vh-zeiw
# download(
#   "https://data.brla.gov/api/views/g9vh-zeiw/rows.csv?accessType=DOWNLOAD",
#   "data/raw/baton_rouge/employee_salaries.csv"
# )

# source: https://data.brla.gov/Government/Legacy-City-Parish-Employee-Annual-Salaries/g5c2-myyj
# download(
#   "https://data.brla.gov/api/views/g5c2-myyj/rows.csv?accessType=DOWNLOAD",
#   "data/raw/baton_rouge/employee_salaries_legacy.csv"
# )

# source: https://data.brla.gov/Public-Safety/City-Court-Warrants/3j5u-jyar
# date_time <- now() %>% str_replace_all(" ","_") %>% str_replace_all("-|:",".")
# download(
#   "https://data.brla.gov/api/views/3j5u-jyar/rows.csv?accessType=DOWNLOAD",
#   paste0("data/raw/baton_rouge/warrants_",date_time,".csv")
# )

# source: https://data.nola.gov/Public-Safety-and-Preparedness/NOPD-Body-Worn-Camera-Metadata/qarb-kkbj
# download(
#   "https://data.nola.gov/api/views/qarb-kkbj/rows.csv?accessType=DOWNLOAD",
#   "data/raw/new_orleans/body_cameras.csv"
# )
