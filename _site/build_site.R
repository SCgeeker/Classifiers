library(distill)
setwd("_site")
## Run this code before you update the site
rmarkdown::clean_site(input = ".",preview = FALSE)
## Copy the latest preregistered plans

## Update the website content
rmarkdown::render_site(encoding = "UTF-8")

## Run this code before initial submission
#file.create(".nojekyll")

