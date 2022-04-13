## Research compendium for 'Jels 3, a new Late Paleolithic open-air site in Denmark, sheds light on the pioneer colonization of northern Europe'.


### Compendium DOI:

[![DOI](https://zenodo.org/badge/480841547.svg)](https://zenodo.org/badge/latestdoi/480841547)

### Maintainer of the repository:

![ORCiD](https://img.shields.io/badge/ORCiD-0000--0002--3468--0986-green.svg) Jesper Borre Pedersen (<jesper.borre@cas.au.dk>) 

### How to cite

Pedersen, Jesper Borre, Poulsen, Martin Egelund & Felix Riede (xxxx). Jels 3, a new Late Paleolithic open-air site in Denmark, sheds light on the pioneer colonization of northern Europe.

### Content

1. [Description](#Description)
2. [Abstract](#Abstract)
3. [Keywords](#Keywords)
4. [Acknowledgements](#Acknowledgements)
5. [Getting Started](#Getting-Started-with-the-Code)
6. [Software Requirements](#Software-Requirements)
7. [Folder Structure](#folder-structure)
8. [License](#License)


### Description

This repository contains the data, code and supplementary information for our manuscript: _Pedersen, Jesper Borre, Poulsen, Martin Egelund & Felix Riede (xxxx). Jels 3, a new Late Paleolithic open-air site in Denmark, sheds light on the pioneer colonization of northern Europe_. 

### Abstract

The Late Upper Paleolithic Hamburgian tradition reflects the earliest known human presence in northern Europe after the Last Glacial Maximum. We here report on the open-air site of Jels 3 (Denmark) and its associated stone tool assemblage, which unambiguously can be attributed to this period. Along with only a handful of other sites, Jels 3 represents the northernmost limits of human expansion in Europe at this time. We conduct a technological analysis of the lithic material from Jels 3 and other relevant sites to shed new light on the behavioral processes that likely underwrote this expansion. Given that sites dating to this initial dispersal remain few, are restricted to certain geographic regions, and represent an overall lack of a well-developed settlement hierarchy we suggest that this dispersal process is most commensurable with the earlier stages of a leap-frogging colonization targeting specific landscape elements, and that it quite possibly was very short-lived.

### Keywords

Late Glacial, human dispersal, lithic technology, landscape learning, mobility, Hamburgian culture


### Acknowledgements

(from the manuscript)

Felix Riede's contribution to this paper is part of CLIOARCH, an ERC Consolidator Grant project that has received funding from the European Research Council (ERC) under the European Union’s Horizon 2020 research and innovation program (grant agreement No. 817564). The technological data on the assemblages from Rietberg 1, Häcklingen 19, Sassenholz 78 and 82, Søvind and Segebro was collected by Christian Steven Hoggard as part of the LAPADIS project (grant #6107-00059B awarded by the Independent Research Fund Denmark) and we would like to thank the University of Cologne, Museum Stade, Moesgaard Museum and the Historical Museum at Lund University respectively for granting access to these. We would also like to thank the Zentrum für Baltische und Skandinavische Archäologie (ZBSA) and the Landesmuseum Schleswig-Holstein for their hospitality and for granting access to the AHR LA 137 (Poggenwisch), AHR LA 139 (Hasewisch) and AHR LA 140 (Meiendorf 2) inventories as well as a special thanks to Dr. Mara-Julia Weber for her assistance. Similarly, we thank VejleMuseerne for kindly making the material from Egtved Mark available for analysis. We would also like to thank David Nicolas Matzig for his assistance regarding the analyses conducted in the R statistical environment. Lastly, JBP would like to thank the University of Aarhus for granting a PhD fellowship.

### Getting Started with the Code

This repository contains the code and the archaeological data required to replicate our analysis.  

The folder structure of this repository and the software requirements for the analysis are outlined below. 

All code required for the analysis and reproduction of the figures can be found in the scripts in the `2_scripts` folder.

### Software Requirements

The analysis was developed and carried out using R version 4.1.3 and the following packages: `tidyverse` (>= 1.3.1), `FactoMineR` (>= 2.4), `here` (>= 1.0.1), `raster` (>= 3.5-15), `sp` (>= 1.4-6), `maptools` (>= 1.1-1).


### Folder Structure

```
├── 1_data              # Archaeological data
    ├── derived_data    # new data files created during the analysis
    └── raw_data        # the raw archaeological data
├── 2_scripts           # The analysis script(s)
├── 3_output            # Visual outputs
    ├── figures         # Figures
    └── tables          # Tables
```



### License

The content of this repository is licensed under a Creative Commons Attribution 4.0 International License: [CC-BY-4.0](http://creativecommons.org/licenses/by/4.0/)
