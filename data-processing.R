# Read an xslx file and convert it as a csv
# write.csv(readxl::read_excel(file.choose()), "data/scenario-A.csv", row.names = F)
scA <- read.csv("data/scenario-A.csv", as.is = T, check.names=FALSE)
scB <- read.csv("data/scenario-B.csv", as.is = T, check.names=FALSE)
scC <- read.csv("data/scenario-C.csv", as.is = T, check.names=FALSE)
scD <- read.csv("data/scenario-D.csv", as.is = T, check.names=FALSE)