#                     --- DSsim TRANSECTS: PRACTISE ---


## load DSsim package and source double observer data sim function
rm(list=ls())
library(DSsim)
setwd("C:/Users/Matthew/Documents/SUMMER SCHOOL/MRDS_bootstrap_variance_estimation")
source("R/write.transects.R")


## region object
coords <- gaps <- list()
coords[[1]] <- list(data.frame(x = c(0,1000,1000,0,0), y = c(0,0,1000,1000,0)))
gaps[[1]] <- list(data.frame(x = c(0,0,0,0,0), y = c(0,0,0,0,0)))

region <- make.region(region.name = "study.area", units = "m",
                      coords = coords, gaps = gaps)


## transects and survey design
n_segs <- 2
zz <- data.frame(x   = c(seq(0, 500, len=n_segs),
                         seq(500, 1000, len=n_segs)),
                 y   = c(seq(0, 1000, len=n_segs),
                         seq(1000, 0, len=n_segs)),
                 leg = c(rep("1", n_segs),
                         rep("2", n_segs)))

unlink("shapes/*")
write.transects(zz, "shapes")

shapefile.pathway <- "C:/Users/Matthew/Documents/SUMMER SCHOOL/MRDS_bootstrap_variance_estimation/shapes"

survey.design <- make.design(transect.type = "Line",
                             design.details = c("user specified"), region = region,
                             plus.sampling =FALSE, path = shapefile.pathway)


## density object
pop.density <- make.density(region.obj = region, x.space = 10,
                            y.space = 10, constant = 0.5)
pop.density <- add.hotspot(pop.density, centre = c(250, 500),
                           sigma = 100, amplitude = 0.2)
pop.density <- add.hotspot(pop.density, centre = c(750, 250),
                           sigma = 100, amplitude = 0.2)



## population description
pop.description <- make.population.description(N = 500, density.obj = pop.density,
                                               region = region, fixed.N = TRUE)


## detectability and ddf analsyses
detect <- make.detectability(key.function = "hn", scale.param = 15,
                             truncation = 30)

ddf.analyses <- make.ddf.analysis.list(dsmodel = list(~cds(key = "hn",formula = ~1),
                                                      ~cds(key = "hr", formula = ~1)),
                                       method = "ds", criteria = "AIC", 
                                       truncation = 30)

my.simulation <- make.simulation(reps = 10, single.transect.set = TRUE,
                                 region.obj = region, design.obj = survey.design,
                                 population.description.obj = pop.description,
                                 detectability.obj = detect, ddf.analyses.list = ddf.analyses)

survey.results <- create.survey.results(my.simulation, dht.table = TRUE)

plot(survey.results)


#---


## transects and survey design
n_segs <- 2
zz <- data.frame(x   = c(seq(0, 500, len=n_segs),
                         seq(500, 1000, len=n_segs)),
                 y   = c(seq(0, 1000, len=n_segs),
                         seq(1000, 0, len=n_segs)),
                 leg = c(rep("1", n_segs),
                         rep("2", n_segs)))


mzz <- rbind(zz,zz,zz,zz,zz)
mzz$x <- mzz$x/5
ind <- 1:nrow(zz)
mzz$x[ind+nrow(zz)] <- mzz$x[ind+nrow(zz)]+1000/5
mzz$x[ind+2*nrow(zz)] <- mzz$x[ind+2*nrow(zz)]+2000/5
mzz$x[ind+3*nrow(zz)] <- mzz$x[ind+3*nrow(zz)]+3000/5
mzz$x[ind+4*nrow(zz)] <- mzz$x[ind+4*nrow(zz)]+4000/5



mzz$leg <- as.numeric(mzz$leg)
mzz$leg[ind+nrow(zz)] <- mzz$leg[ind+nrow(zz)]+2
mzz$leg[ind+2*nrow(zz)] <- mzz$leg[ind+2*nrow(zz)]+4
mzz$leg[ind+3*nrow(zz)] <- mzz$leg[ind+3*nrow(zz)]+6
mzz$leg[ind+4*nrow(zz)] <- mzz$leg[ind+4*nrow(zz)]+8

mzz$leg <- as.character(mzz$leg)

unlink("shapes/*")
write.transects(mzz, "shapes")
survey.design <- make.design(transect.type = "Line",
                             design.details = c("user specified"), region = region,
                             plus.sampling =FALSE, path = shapefile.pathway)


## results
my.simulation <- make.simulation(reps = 10, single.transect.set = TRUE,
                                 region.obj = region, design.obj = survey.design,
                                 population.description.obj = pop.description,
                                 detectability.obj = detect, ddf.analyses.list = ddf.analyses)

survey.results <- create.survey.results(my.simulation, dht.table = TRUE)

plot(survey.results)


#---


## transects and survey design
n_segs <- 2
lines <- data.frame(x   = c(rep(seq(0, 1000, len=n_segs), 4)),
                    y   = c(seq(200, 200, len=n_segs),
                            seq(400, 400, len=n_segs),
                            seq(600, 600, len=n_segs),
                            seq(800, 800, len=n_segs)),
                    leg = c(rep("1", n_segs),
                            rep("2", n_segs),
                            rep("3", n_segs),
                            rep("4", n_segs)))


unlink("shapes/*")
write.transects(lines, "shapes")
survey.design <- make.design(transect.type = "Line",
                             design.details = c("Parallel","Systematic"), region = region,
                             plus.sampling =FALSE, path = shapefile.pathway)


## results
my.simulation <- make.simulation(reps = 10, single.transect.set = TRUE,
                                 region.obj = region, design.obj = survey.design,
                                 population.description.obj = pop.description,
                                 detectability.obj = detect, ddf.analyses.list = ddf.analyses)

survey.results <- create.survey.results(my.simulation, dht.table = TRUE)

plot(survey.results)



#---


## transects and survey design
n_segs <- 2
lines.many <- data.frame(x   = c(rep(seq(0, 1000, len=n_segs), 9)),
                         y   = c(seq(100, 100, len=n_segs),
                                 seq(200, 200, len=n_segs),
                                 seq(300, 300, len=n_segs),
                                 seq(400, 400, len=n_segs),
                                 seq(500, 500, len=n_segs),
                                 seq(600, 600, len=n_segs),
                                 seq(700, 700, len=n_segs),
                                 seq(800, 800, len=n_segs),
                                 seq(900, 900, len=n_segs)),
                         leg = c(rep("1", n_segs),
                                 rep("2", n_segs),
                                 rep("3", n_segs),
                                 rep("4", n_segs),
                                 rep("5", n_segs),
                                 rep("6", n_segs),
                                 rep("7", n_segs),
                                 rep("8", n_segs),
                                 rep("9", n_segs)))

                         
unlink("shapes/*")
write.transects(lines.many, "shapes")
survey.design <- make.design(transect.type = "Line",
                             design.details = c("Parallel","Systematic"), region = region,
                             plus.sampling =FALSE, path = shapefile.pathway)


## results
my.simulation <- make.simulation(reps = 10, single.transect.set = TRUE,
                                 region.obj = region, design.obj = survey.design,
                                 population.description.obj = pop.description,
                                 detectability.obj = detect, ddf.analyses.list = ddf.analyses)

survey.results <- create.survey.results(my.simulation, dht.table = TRUE)

plot(survey.results)


