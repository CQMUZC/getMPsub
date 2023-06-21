#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'


####getMPsub fubction####
getMPsub <- function(tpm, pdata) {
  # Load template data
  if(!require("MOVICS")) devtools::install_github("xlucpu/MOVICS",update = F,ask = F)
  if(!require("openxlsx")) install.packages("openxlsx",update = F,ask = F)
  MPsub_marker <- read.xlsx(system.file("data", "MPsub_marker.xlsx",
                                        package = "getMPsub", mustWork = TRUE))

  # Run NTP analysis
  tpm_ntp_pred <- runNTP(expr = tpm,
                         templates = MPsub_marker,
                         distance = "pearson",
                         scaleFlag = TRUE,
                         centerFlag = TRUE,
                         doPlot = TRUE,
                         fig.name = "NTP HEATMAP")

  # Perform survival analysis
  surv <- compSurv(moic.res = tpm_ntp_pred,
                   surv.info = pdata,
                   convt.time = "m",
                   surv.median.line = "hv",
                   clust.col = c("#F47E62", "#6F80BE"),
                   fig.name = "KAPLAN-MEIER CURVE OF NTP")

  return(getMPsub<-list(ntp_pred = tpm_ntp_pred, surv = surv))
}

