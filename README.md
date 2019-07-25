# DnD data analysis exercises
Practicing data analysis using DnD stats

#######################################
###### Installing R and R Tools #######
#######################################

* R Installer: https://cran.r-project.org/bin/macosx/
* R Tools Installer (to enable compiling for binaries): https://cran.r-project.org/bin/macosx/tools/

#######################################
####### NOTES ON BEST PRACTICE ########
#######################################

# Use Projects rather than including rm(list=ls()): 
# * Why? 
#   * rm() doesn't actually ensure a truly clean workspace due to hidden items.
#   * Using a Project eliminates the need for local file directory paths, which will break on different computers.
#   * Allows the use of the here() package and function which ensures better cross-system compatability.
# * How?
#   * When starting a new project, use File > New Project the first time you create a new file.
#   * To ensure a clean workspace on startup, use RStudio > Preferences > General
#     * Uncheck "Restore .RData..."
#     * Set "Save Workspace to .RData on exit" to "never"
#     * Uncheck "Always save history..."
#   * Access Projects by opening them directly from the Finder, using File > Open Project, or using the Project drop-down in the upper-right of RStudio.
