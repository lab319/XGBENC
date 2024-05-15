result_mean <- function(type,data_1,data_2,data_3,data_4,data_5){
data_fin = list()

data_fin$fp_1 = (data_1$fp_1+data_2$fp_1+data_3$fp_1+data_4$fp_1+data_5$fp_1)/5
data_fin$fp_3 = (data_1$fp_3+data_2$fp_3+data_3$fp_3+data_4$fp_3+data_5$fp_3)/5
data_fin$fp_5 = (data_1$fp_5+data_2$fp_5+data_3$fp_5+data_4$fp_5+data_5$fp_5)/5
data_fin$fp_10 = (data_1$fp_10+data_2$fp_10+data_3$fp_10+data_4$fp_10+data_5$fp_10)/5

data_fin$tp_1 = (data_1$tp_1+data_2$tp_1+data_3$tp_1+data_4$tp_1+data_5$tp_1)/5
data_fin$tp_3 = (data_1$tp_3+data_2$tp_3+data_3$tp_3+data_4$tp_3+data_5$tp_3)/5
data_fin$tp_5 = (data_1$tp_5+data_2$tp_5+data_3$tp_5+data_4$tp_5+data_5$tp_5)/5
data_fin$tp_10 = (data_1$tp_10+data_2$tp_10+data_3$tp_10+data_4$tp_10+data_5$tp_10)/5

data_fin$auc_1 = (data_1$auc_1+data_2$auc_1+data_3$auc_1+data_4$auc_1+data_5$auc_1)/5
data_fin$auc_3 = (data_1$auc_3+data_2$auc_3+data_3$auc_3+data_4$auc_3+data_5$auc_3)/5
data_fin$auc_5 = (data_1$auc_5+data_2$auc_5+data_3$auc_5+data_4$auc_5+data_5$auc_5)/5
data_fin$auc_10 = (data_1$auc_10+data_2$auc_10+data_3$auc_10+data_4$auc_10+data_5$auc_10)/5


## auc another // _span

data_fin$fp_span_1 = (data_1$fp_span_1+data_2$fp_span_1+data_3$fp_span_1+data_4$fp_span_1+data_5$fp_span_1)/5
data_fin$fp_span_3 = (data_1$fp_span_3+data_2$fp_span_3+data_3$fp_span_3+data_4$fp_span_3+data_5$fp_span_3)/5
data_fin$fp_span_5 = (data_1$fp_span_5+data_2$fp_span_5+data_3$fp_span_5+data_4$fp_span_5+data_5$fp_span_5)/5
data_fin$fp_span_10 = (data_1$fp_span_10+data_2$fp_span_10+data_3$fp_span_10+data_4$fp_span_10+data_5$fp_span_10)/5

data_fin$tp_span_1 = (data_1$tp_span_1+data_2$tp_span_1+data_3$tp_span_1+data_4$tp_span_1+data_5$tp_span_1)/5
data_fin$tp_span_3 = (data_1$tp_span_3+data_2$tp_span_3+data_3$tp_span_3+data_4$tp_span_3+data_5$tp_span_3)/5
data_fin$tp_span_5 = (data_1$tp_span_5+data_2$tp_span_5+data_3$tp_span_5+data_4$tp_span_5+data_5$tp_span_5)/5
data_fin$tp_span_10 = (data_1$tp_span_10+data_2$tp_span_10+data_3$tp_span_10+data_4$tp_span_10+data_5$tp_span_10)/5

data_fin$auc_span_1 = (data_1$auc_span_1+data_2$auc_span_1+data_3$auc_span_1+data_4$auc_span_1+data_5$auc_span_1)/5
data_fin$auc_span_3 = (data_1$auc_span_3+data_2$auc_span_3+data_3$auc_span_3+data_4$auc_span_3+data_5$auc_span_3)/5
data_fin$auc_span_5 = (data_1$auc_span_5+data_2$auc_span_5+data_3$auc_span_5+data_4$auc_span_5+data_5$auc_span_5)/5
data_fin$auc_span_10 = (data_1$auc_span_10+data_2$auc_span_10+data_3$auc_span_10+data_4$auc_span_10+data_5$auc_span_10)/5

data_fin$cindex_rsf = (data_1$cindex+data_2$cindex+data_3$cindex+data_4$cindex+data_5$cindex)/5

save("data_fin", file = sprintf("%s_fin_result.RData",type))




}