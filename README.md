# DnD data analysis exercises
Practicing data analysis using DnD stats

## Installing R, R Tools, and Packages

* **R Installer**: https://cran.r-project.org/bin/macosx/
* **R Tools Installer** (to enable compiling for binaries): https://cran.r-project.org/bin/macosx/tools/
* When **installing a package** use _install.packages('[PACKAGE_NAME]', dependencies = T)_
  * First, choose "yes" when asked whether to install from binaries.
  * For any that fail (warning message: "installation of package '[PACKAGE_NAME]' had non-zero exit status"), run _install.packages()_ for that package only, and choose "no" when asked whether to install from binaries.
* **Load in packages** using _library([PACKAGE_NAME])_.

## Notes on Best Practice

1. **Use Projects rather than including _rm(list=ls())_:** 
   * **Why?** 
     * _rm()_ doesn't actually ensure a truly clean workspace due to hidden items.
     * Using a Project eliminates the need for local file directory paths, which will break on different computers.
     * Allows the use of the _here()_ package and function which ensures better cross-system compatability.
   * **How?**
     * **When starting a new project**, use _File > New Project_ the first time you create a new file.
     * **To ensure a clean workspace** on startup, use _RStudio > Preferences > General_:
       * Uncheck "Restore .RData..."
       * Set "Save Workspace to .RData on exit" to "never"
       * Uncheck "Always save history..."
     * **Access Projects** by doing any of the following:
       * opening them directly from the Finder
       * clicking _File > Open Project_
       * using the Project drop-down in the upper-right of RStudio.
       
2. **Be intentional in making graphs colorblind-accessible:**
  * **Why?**
      * The default ggplot palette is not strongly differentiated in value
      * Non-colorblind-friendly palettes are not only inaccessible, but unclear when printed in black and white
  * **How?**
    * Use premade palettes created with colorblindness in mind:
      * A particluarly good one is Viridis, found and explained here: https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
    * Another option is to use the following:
Colorblind-friendly palette
cbPalette <- c("#999999", # Dark Gray
               "#E69F00", # Mustard Yellow
               "#56B4E9", # Sky Blue
               "#009E73", # Strong Green
               "#F0E442", # Lemon Yellow
               "#0072B2", # Denim Blue
               "#D55E00", # Rust Orange
               "#CC79A7") # Lavender
To use for fills, add
scale_fill_manual(values=cbPalette)
To use for line and point colors, add
scale_colour_manual(values=cbPalette)
