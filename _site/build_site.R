library(distill)
## Run this code before you update the site
rmarkdown::clean_site(input = "./docs/",preview = FALSE)
## Copy the latest preregistered plans
setwd("_site")

## Update the website content
rmarkdown::render_site(encoding = "UTF-8")

## Run this code before initial submission
#file.create(".nojekyll")

