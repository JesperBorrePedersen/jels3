library(tidyverse)
library(here)

# reading the data
tech <- readr::read_csv(here("1_data/raw_data/jels3_tech_data.csv"))


# selecting only complete, unmodified and uncortical blades as well as removing some attributes not relevant to the current analysis
blades <- tech %>%
  filter(artefact == "Blade", ba_1_1 == 1, ba_13_3 == "0", ba_13_4 == "0") %>%
  dplyr::select(-ba_4_1, -ba_4_2, -ba_4_3, -ba_5_1, -ba_5_2, -ba_5_3, -ba_7_7, -ba_8_1, -ba_11_4, -ba_13_1, -ba_13_2)



## plotting figure 7 and 8

blades$site <- factor(blades$site, levels = c("Jels 3", "Jels 2", "Jels 1",
                                                                      "AHR LA 137 (Poggenwisch)", "AHR LA 139 (Hasewisch)",
                                                                      "AHR LA 140 (Meiendorf 2)", "Egtved mark",
                                                                      "Rietberg 1", "Häcklingen 19", "Sassenholz 78",
                                                                      "Sassenholz 82", "Søvind", "Segebro"))

blades$classification <- factor(blades$classification, levels = c("Havelte Group",
                                                                                  "Classic Hamburgian",
                                                                                          "Federmesser",
                                                                                          "Bromme"))


# renaming "Federmesser" and "Bromme" to "Late Glacial"
levels(blades$classification) <- c("Havelte Group",
                                               "Classic Hamburgian",
                                               "Late Pleistocene (other)",
                                               "Late Pleistocene (other)")

# plotting and saving figure 7

jpeg(file="3_output/figures/fig_7.jpeg") #setting up for saving plot as jpeg



fig_7 <- ggplot(data = blades, aes(x = length, y = width, group = classification)) +
  geom_point(aes(color = classification), size = 2) +
  geom_point(size = 2.0, alpha = 1, na.rm = T, shape = 21, colour = "grey0") +
  scale_color_manual(values = c("grey30", "grey70", "grey100")) +
  theme_minimal() +
  labs(y= "Width (mm)", x = "Length (mm)") +
  theme(legend.position = "none",
        aspect.ratio = 0.35,
        strip.text.x = element_text(size = 10, face = "bold")) +
  facet_wrap(~ classification, ncol = 1)

fig_7

dev.off() #calling off saving function


# plotting and saving figure 8

jpeg(file="3_output/figures/fig_8.jpeg",
     width = 900, height = 650) #setting up for saving plot as jpeg


fig_8 <- ggplot(data = blades, aes(x = width, y = site, group = site,
                                                  fill = classification)) +
  geom_boxplot() +
  scale_fill_manual(values = c("grey30", "grey70", "grey100")) +
  scale_x_continuous(breaks = seq(0, 60, by = 10)) +
  labs(x = "Width (mm)",
       y =  "Site",
       title = "") +
  # overlay data points
  ggbeeswarm::geom_quasirandom(alpha = 0.1, groupOnX = FALSE) +
  theme_classic(base_size = 14) +
  theme(legend.position = "top",
        legend.title = element_blank()) +
  scale_y_discrete(limits = rev(unique(sort(blades$site))))

fig_8

dev.off() #calling off saving function


# Correspondence analysis
CA <-
  blades %>%
  dplyr::select(c(25:71)) %>% # do the CA only on the columns that are binary
  FactoMineR::CA()


# plotting the CA in ggplot:
# extract the coordinates and put them into a datafrme (here: coordinates of first two dimensions only)
CA_axes_1and2 <- as.data.frame(CA$row$coord[,c(1:2)]) # just get first and second axis of CA
names(CA_axes_1and2) <- c("Dim1", "Dim2") # rename

CA_2 <- cbind(blades %>%
                       dplyr::select(c(1:13)),
                       CA_axes_1and2) # combine the CA axis with your additional info from "data" (assuming that the row order didnt change)
CA_2$site <- as.factor(CA_2$site) # make as factor when you want something to be reconized as a grouping lable



# ordering data according to classification
CA_2$classification <- factor(CA_2$classification, levels = c("Havelte Group",
                                                                            "Classic Hamburgian",
                                                                            "Federmesser",
                                                                            "Bromme"))
# renaming "Federmesser" and "Bromme" to "Late Glacial"
levels(CA_2$classification) <- c("Havelte Group",
                                        "Classic Hamburgian",
                                        "Late Pleistocene (other)",
                                        "Late Pleistocene (other)")


# plotting and saving figure 10

jpeg(file="3_output/figures/fig_10.jpeg") #setting up for saving plot as jpeg


fig_10 <- ggplot(data = CA_2, aes(x = Dim1, y = Dim2)) +
  geom_point(aes(color = classification), size = 2,)  +
  geom_point(size = 2.0, alpha = 1, na.rm = T, shape = 21, colour = "black") +
  scale_color_manual(values = c("grey30", "grey70", "grey100")) +
  theme(panel.background = element_blank(),
        strip.background = element_rect(colour = "white", fill = "white"),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        legend.position = "none",
        strip.text.x = element_text(size = 10, face = "bold")) +
  labs(y= "Dimension 2", x = "Dimension 1")  +
  xlim(-2.5, 2.5) +
  ylim(-2.5, 2.5)+
  geom_hline(yintercept=0) +
  geom_vline(xintercept=0)+
  facet_wrap(~ classification, ncol = 1)

fig_10

dev.off() #calling off saving function


# Creating summary tables  of length and width of blade material for supplementary information

sum_length <- blades %>%
  group_by(site) %>%
  summarize(n = n(),
            min = round(min(length), 1),
            max = round(max(length), 1),
            mean = round(mean(length), 1),
            range = round(max(length) - min(length), 1),
            sd = round(sd(length), 1),
            cv = round((DescTools::CoefVar((length), unbiased = TRUE)*100), 1),
            lq = round(quantile(length, 0.25), 1),
            uq = round(quantile(length, 0.75), 1))

sum_length


write.csv(sum_length,(here("3_output/tables/table_si_1.csv")), row.names = FALSE) #saving table


sum_width <- blades %>%
  group_by(site) %>%
  summarize(n = n(),
            min = round(min(width), 1),
            max = round(max(width), 1),
            mean = round(mean(width), 1),
            range = round(max(width) - min(width), 1),
            sd = round(sd(width), 1),
            cv = round((DescTools::CoefVar((width), unbiased = TRUE)*100), 1),
            lq = round(quantile(width, 0.25), 1),
            uq = round(quantile(width, 0.75), 1))

sum_width

write.csv(sum_width,(here("3_output/tables/table_si_2.csv")), row.names = FALSE) #saving table

