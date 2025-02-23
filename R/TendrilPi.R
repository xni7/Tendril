#Do the Percentile calculations on the permutations
TendrilPi <- function(tendril, Permterm, perm.data, pi.low=0.1, pi.high=0.9, perm.from.day = 1) {

  actualdata <- tendril$data[tendril$data$Terms == Permterm,]
  actualdata$type <- "Actual"
  actualdata$label <- "Actual"
  actualdata$perm.from.day = perm.from.day

  data <- perm.data

  add_continues_angle <- function(dataset){
    dataset$ang_continues <- dataset$ang
    n_rows <- length(dataset$ang_continues)
    if (n_rows > 1){
      for (j in 2:n_rows){
        if (abs(dataset$ang_continues[j] - dataset$ang_continues[j-1]) > pi ){
          if ((dataset$ang_continues[j] - dataset$ang_continues[j-1]) > 0){
            dataset$ang_continues[j:n_rows] <- dataset$ang_continues[j:n_rows] - 2*pi
          } else {
            dataset$ang_continues[j:n_rows] <- dataset$ang_continues[j:n_rows] + 2*pi
          }
        }
      }
    }
    return(dataset)
  }

  data$ang_continues <- data$ang

  for(i in unique(data$label)){
    data[data$label == i,] <- add_continues_angle(data[data$label == i,])
  }

  polydata <- data[data$type == "Permutation" & data$StartDay >= perm.from.day, ]
  polydata <- polydata[order(polydata$ang_continues, decreasing = FALSE), ]

  labelleddata <- NULL
  for(i in unique(polydata$StartDay)) {
    subset<-polydata[polydata$StartDay==i,]
    size <- dim(subset)[1]
    limit.low <- size*pi.low
    limit.high <- size*pi.high

    subset$label[limit.low]<-"Low.percentile"
    subset$label[limit.high]<-"High.percentile"
    labelleddata<-rbind(labelleddata, subset)
}

  labelleddata <- with(labelleddata, labelleddata[ order(type,StartDay),])
  labelleddata$type[labelleddata$label=="Low.percentile" | labelleddata$label=="High.percentile"] <- "Percentile"
  labelleddata <- labelleddata[,colnames(labelleddata) %in% colnames(actualdata)]
  data <- rbind(labelleddata, actualdata)
  data$perm.from.day <- perm.from.day
  data <- data[data$type == "Percentile",]
  class(data) <- "TendrilPi"

  return(data)
}
