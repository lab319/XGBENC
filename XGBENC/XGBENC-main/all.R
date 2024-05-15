rm(list=ls())
gc()


library(rbsurv)
library(survival)
library(Biobase)
library(randomForestSRC)
library(survivalROC)
library(Hmisc)
library(xgboost)
library(Matrix)
library(glmnet)

## 读取数据集
clinical <- read.table(file="TCGA clinical data.txt",T) ## 读取临床数据
clinical <- data.frame(clinical)
dim(clinical)		#497*3
head(clinical)
time <- clinical$time
status <- clinical$status
RNA <- read.table(file="TCGA RNA data.txt",T)  ## 读取RNA-Seq基因表达数据
RNA <- data.frame(RNA,stringsAsFactors=TRUE)
dim(RNA)		#497*16321
RNA1 <- cbind(RNA,time,status)	
x <- RNA1

### 5折交叉验证划分训练集和测试集，生存和死亡样本比例保持一致
### for循环5次做不同折数
###
for (fold in c(1,2,3,4,5)){

  source("ratio_sample.R")
  cross_va_sample(x,1234,fold)

  x.train <- read.table(file="x.train.txt",T)
  x.test <- read.table(file="x.test.txt",T)
  t.train <- x.train$time
  t.test <- x.test$time
  s.train <- x.train$status
  s.test <- x.test$status

  nthreads <- 24

### 模型调参 同采用5折交叉验证

### XGB

  num_feature <- dim(x.train)[2]
  #head(x.train[1:5,(num_feature-2):num_feature])

  x.train.xgb <- data.matrix(x.train) # 将自变量转化为矩阵
  dtrain<-list(data=x.train.xgb[,c(2:(num_feature-2))],label=x.train.xgb[,(num_feature-1)]*(-(-1)^(as.numeric(x.train.xgb[,num_feature]))))	#time*（-status） 为删失数据是为负数
  Dtrain<-xgb.DMatrix(dtrain$data,label=dtrain$label)
  x.test.xgb <- data.matrix(x.test) # 将自变量转化为矩阵
  dtest<-list(data=x.test.xgb[,c(2:(num_feature-2))],label=x.test.xgb[,(num_feature-1)]*(-(-1)^(as.numeric(x.test.xgb[,num_feature]))))	#time
  Dtest<-xgb.DMatrix(dtest$data,label=dtest$label)

### OUR MODEL
### 存下来 best_param 在找参数lambda2

  best_param = list()
  best_loss = Inf
  best_loss_index = 0
  seed.number = 4321
  watchlist = list(train = Dtrain, test = Dtest)

  source("myobjtiaocan.R")
  my_xgb_param(best_param,best_loss,best_lost_index,seed.number,watchlist,fold, nthreads)

  ### 调参lambda2
  load(file = sprintf("%d_my_xgb_result.RData",fold))
  source("xgbenc_2.R")
  xgbenc_param_2(x.train.xgb, result$best_param, result$nround, fold, nthreads)


}



## 得到平均值
##5折交叉验证结束



### MY MODEL
###  NEW USE
load("1_xgbenc_result.RData")
result_my_1 = result
load("2_xgbenc_result.RData")
result_my_2 = result
load("3_xgbenc_result.RData")
result_my_3 = result
load("4_xgbenc_result.RData")
result_my_4 = result
load("5_xgbenc_result.RData")
result_my_5 = result

##交叉验证结果求平均  平均cindex、平均auc、画auc图
source("result_mean.R")
result_mean("my",result_my_1,result_my_2,result_my_3,result_my_4,result_my_5)
load("my_fin_result.RData")
my_fin_result = data_fin



######


my_fin_result$cindex

my_fin_result$auc_3

















