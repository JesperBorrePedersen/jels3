
# reading in packages
library(tidyverse)
library(here)
library(raster)


# reading the data
grid <- readr::read_csv(here("1_data/raw_data/jels3_grid.csv"))
exdata <- readr::read_csv(here("1_data/raw_data/jels3_excavation_data.csv"))


# The first part of this script is explaining how the two RData files used for the final plot was made.
# Further down (line 57) the script for making the actual figures of the excavation grid,
# using the saved RData files can be found

box <- with(grid, c(min(east), max(east)+1, min(north), max(north)+1))

plot(NA, xlim = box[1:2], ylim = box[3:4], xlab = "east", ylab = "north", main = "grid",
     type = "n", asp = 1)

with(grid, text(east+.5, north+.5, as.character(square), cex = .75))

mkgrid <- function(x, y) {
  E <- c(rep(x, 2), rep(x+1, 2))
  N <- c(y, rep(y+1, 2), y)
  cbind(E, N)}
Units <- with(grid, mapply(mkgrid, east, north, SIMPLIFY = FALSE))
names(Units) <- with(grid, sprintf("E%02.0fN%02.0f", east, north))
for(i in 1:243) {
  polygon(Units[[i]], border = "dark gray")
}


# making the border
Bounds <- locator()

Border <- sapply(Bounds, round)
colnames(Border) <- c("east", "north")
polygon(Border, border="black", lwd=2)
save(Units, Border, file="1_data/derived_data/jels3Map1.RData")

#choropleth map

library(sp)
library(maptools)

Polys <- lapply(Units, function(x) rbind(x, x[1,]))
Polylist <- lapply(Polys, function(x) Polygon(x, hole=FALSE))
PolysList <- lapply(seq_along(Polylist), function(x)
  Polygons(Polylist[x], names(Units)[x] ))
Quads <- SpatialPolygons(PolysList, seq_along(PolysList))
boundary <- unionSpatialPolygons(Quads, rep(1, 243))
save(Quads, boundary, file= "1_data/derived_data/jels3Map2.RData")


# Plotting using the RData files and dplyr::mutate

load(here("1_data/derived_data/jels3Map1.RData"))
load(here("1_data/derived_data/jels3Map2.RData"))


## make a new column with categories for total debiatge per square based on total_count

tib_grid <- grid %>% mutate(Group = case_when(total_count <= 0 ~ "0",
                                              total_count <= 10 ~ "1-10",
                                              total_count <= 20 ~ "10-20",
                                              total_count <= 30 ~ "20-30",
                                              total_count <= 50 ~ "30-50",
                                              total_count <= 70 ~ "50-70",
                                              total_count <= 250 ~ ">200"))

## specifying the factor levels in the order you want
tib_grid$Group <- factor(tib_grid$Group, levels = c("0", "1-10", "10-20", "20-30", "30-50", "50-70", ">200"))

gcol <- gray(7:0/7)
plot(Quads, col=gcol[as.factor(tib_grid$Group)])
title("A)", adj = 0.1)
legend (-5, 9, levels(tib_grid$Group), fill = gcol[1:7], title= "Debitage per unit")
scalebar(400, xy= c(-4.2, 0), type="bar", divs=4, below = "m", label = c(1, NA, 4),
         lonlate= NULL)





#dot denisty map with burnt material
set.seed(2)
dots <- dotsInPolys(Quads, as.integer(grid$burnt/1))
plot(Quads, lty=0)
title("B)", adj = 0.1)
points(dots, pch=20, cex=.5)
plot(boundary, add=TRUE)
scalebar(400, xy= c(-5, 1), type="bar", divs=4, below = "m", label = c(1, NA, 4), transform = FALSE)


## The final combination of the two plots was done in the image editing software Gimp (https://www.gimp.org/)





# making a summary table of all finds and their context (Table 2 in the manuscript)

table <- filter(exdata, grid == "y") %>%
  group_by(spit) %>%
  summarize(Flakes = sum(`flake_(n)`),
            Blades = sum(`blade_(n)`),
            BladesF = sum(`blade_fragment_(n)`),
            Cores = sum(`core_(n)`),
            BladeR = sum(`blade_retouche_(n)`),
            BladeFR = sum(`blade_fragment_retouche_(n)`),
            FlakeR = sum(`flake_retouche_(n)`),
            BurinF = sum(`flake_burin_(n)`),
            BurinB = sum(`blade_burin_(n)`),
            BurinBF = sum(`blade_burin_fragment_(n)`),
            SraperFlake = sum(`flake_scraper_(n)`),
            ScraperBlade = sum(`blade_scraper_(n)`),
            ScraperBladeF = sum(`blade_scraper_fragment_(n)`),
            Borer = sum(`borer_blade_(n)`),
            BorerBF = sum(`borer_blade_fragment_(n)`),
            Combo = sum(`combination_tool_(n)`),
            Zinken = sum(`zinken_(n)`),
            ZinkenF = sum(`zinken_borer_fragment_(n)`),
            Projectile = sum(`projectile_(n)`))
table

table$rowSum <- rowSums(table[,2:ncol(table)]) # row sums for counts
tool_sums <- colSums(table[, 2:(ncol(table))]) # col sums for counts

table <- dplyr::bind_rows(table, tool_sums) # merge
table[nrow(table), "spit"] <- "colSum"



table_t <- t(table) # transpose s. ?t()
table_t <- gsub(" *", "", x = table_t) # somehow " " get introduced in the step above which have to be removed first
# as.integer(table_t[2:nrow(table_t)],)


df <- as.data.frame(table_t)
colnames(df) <- table_t[1,]
df$tools <- row.names(df)
rownames(df) <- NULL

df2 <- df[2:nrow(df),]
table_2 <- subset(df2, select=c(ncol(df2),1:(ncol(df2)-1))) %>% # get "tools" column to the front
  mutate_at(c(2:ncol(df2)), as.character) %>%  # is factor, has to be converted to character first
  mutate_at(c(2:ncol(df2)), as.integer) %>%  # now, char to int
  as_tibble()

table_2

# The final editing was done manually in ms word, but the figures are published as they were calculated here
