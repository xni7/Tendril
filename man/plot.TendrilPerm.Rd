% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot.TendrilPerm.R
\name{plot.TendrilPerm}
\alias{plot.TendrilPerm}
\title{Plot TendrilPerm}
\usage{
\method{plot}{TendrilPerm}(x, ...)
}
\arguments{
\item{x}{An object of class TendrilPerm, as made by TendrilPerm()}

\item{...}{Additional parameters that can be passed to the function:
- percentile: Specifies if the plot must show percentile values. Default
  is FALSE.}
}
\description{
Function to plot TendrilPerm results
}
\examples{
# generate data using Tendril()
data <- Tendril(mydata = TendrilData,
rotations = Rotations,
AEfreqTreshold = 9,
Tag = "Comment",
Treatments = c("placebo", "active"),
Unique.Subject.Identifier = "subjid",
Terms = "ae",
Treat = "treatment",
StartDay = "day",
SubjList = SubjList,
SubjList.subject = "subjid",
SubjList.treatment = "treatment"
)
tendril_perm <- TendrilPerm(
  tendril = data,
  PermTerm="AE40",
  n.perm = 200,
  perm.from.day = 1)

#Do plot
res <- plot(tendril_perm)
res <- plot(tendril_perm, percentile = TRUE)

#To re-do the plot after the first call:
print(res)
}
