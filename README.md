# jels3

## Description

This repository contains the data, code and supplementary information for our manuscript: _Jels 3, a new Late Paleolithic open-air site in Denmark, sheds light on the pioneer colonization of northern Europe._

## Content
1. [Authors](#Authors)
2. [Citation](#Citation)
3. [Acknowledgements](#Acknowledgements)
4. [Getting Started](#Getting-Started-with-the-Code)
5. [Software Requirements](#Software-Requirements)
6. [Folder Structure](#folder-structure)
7. [License](#License)

## Authors
Jesper Borre Pedersen, Martin Egelund Poulsen, Felix Riede.

Contact: jesper.borre@cas.au.dk

## Citation

Pedersen, Jesper B., Poulsen, Martin E. & Felix Riede (xxxx): _Jels 3, a new Late Paleolithic open-air site in Denmark, sheds light on the pioneer colonization of northern Europe_.

## Acknowledgements
(from the manuscript)

Felix Riede's contribution to this paper is part of CLIOARCH, an ERC Consolidator Grant project that has received funding from the European Research Council (ERC) under the European Union’s Horizon 2020 research and innovation program (grant agreement No. 817564). The technological data on the assemblages from Rietberg 1, Häcklingen 19, Sassenholz 78 and 82, Søvind and Segebro was collected by Christian Steven Hoggard as part of the LAPADIS project (grant #6107-00059B awarded by the Independent Research Fund Denmark) and we would like to thank the University of Cologne, Museum Stade, Moesgaard Museum and Lund University respectively for granting access to these. We would also like to thank the Zentrum für Baltische und Skandinavische Archäologie (ZBSA) and the Landesmuseum Schleswig-Holstein for their hospitality and for granting access to the AHR LA 137 (Poggenwisch), AHR LA 139 (Hasewisch) and AHR LA 140 (Meiendorf 2) inventories as well as a special thanks to Dr. Mara-Julia Weber for her assistance. Similarly, we thank VejleMuseerne for kindly making the material from Egtved Mark available for analysis. We would also like to thank David Nicolas Matzig for his assistance regarding the analyses conducted in the R statistical environment. Lastly, JBP would like to thank the University of Aarhus for granting a PhD fellowship.

## Getting Started with the Code
This repository contains the code and the archaeological data required to replicate our analysis.  

The folder structure of this repository and the software requirements for the analysis are outlined below. 

All code required for the analysis and reproduction of the figures can be found in the scripts in the `2_scripts` folder.

### Software Requirements
The analysis was developed and carried out using R version 4.1.3 and the following packages: tidyverse 1.3.1, FactoMineR 2.4, here 1.0.1, raster 3.5-15, sp 1.4-6, maptools 1.1-1.


### Folder Structure

```
├── 1_data              # Archaeological data
    ├── derived_data    # new data files created during the analysis
    └── raw_data        # the raw archaeological data
├── 2_scripts           # The analysis script(s)
├── 3_figures           # Figure outputs
```



## License
The content of this repository is licensed under a Creative Commons Attribution 4.0 International License: [CC-BY-4.0](http://creativecommons.org/licenses/by/4.0/)
