#Import library
library(IETD)
library(plyr)
library(dplyr)
library(data.table)

#Import rainfall timeseries CSVs into single dataframe (list of dataframes)
fn <- list.files(path ="C:/Projects/Side_Projects/Monte_Carlo/Script/Input", pattern = "*.csv", full.names = TRUE)
df <- lapply(fn, read.csv)

#Extraction of independent rainfall events from all sub-daily timeseries
events <- lapply(df, function(X){drawre(Time_series = hourly_time_series, IETD = 6, Thres = 10)})

#Combine rainfall characteristics summary table and export as CSV
characteristic_df <- bind_rows(events)
rainfall_characteristics_summary <- subset(characteristic_df, select = -c(Rainfall_Events))
write.csv(rainfall_characteristics_summary, "C:/Projects/Side_Projects/Monte_Carlo/Script/Output/Filtered_Rainfall_Characteristics.csv", row.names = FALSE)

#Single out rainfall event nested lists
rf_event <- lapply(events, function(x) x[[2]])

#Remove one layer of nested list
rf_event_summary <- unlist(rf_event,recursive=FALSE)

#Delete datetime column in preparation of array creation
rf_event_summary <- lapply(rf_event_summary, function(x) {x["Date"] <- NULL; x })

#Convert array to dataframe
rf_event_summary <- rbind.fill(lapply(rf_event_summary,function(x){x
  as.data.frame(t(x),stringsAsFactors=FALSE)
}))

#Export data
capture.output(rf_event,file = "C:/Projects/Side_Projects/Monte_Carlo/Script/Output/Filtered_Rainfall_Events.csv", row.names = FALSE)
write.csv(rf_event_summary, file = "C:/Projects/Side_Projects/Monte_Carlo/Script/Output/Filtered_Rainfall_Events_ts_input.csv", row.names = FALSE)
