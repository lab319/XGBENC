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

## ��ȡ���ݼ�
clinical <- read.table(file="TCGA clinical data.txt",T) ## ��ȡ�ٴ�����
clinical <- data.frame(clinical)
dim(clinical)		#497*3
head(clinical)
time <- clinical$time
status <- clinical$status
RNA <- read.table(file="TCGA RNA data.txt",T)  ## ��ȡRNA-Seq�����������
RNA <- data.frame(RNA,stringsAsFactors=TRUE)
dim(RNA)		#497*16321
RNA1 <- cbind(RNA,time,status)	
x <- RNA1

### 5�۽�����֤����ѵ�����Ͳ��Լ������������������������һ��
### forѭ��5������ͬ����
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

### ģ�͵��� ͬ����5�۽�����֤

### XGB

  num_feature <- dim(x.train)[2]
  #head(x.train[1:5,(num_feature-2):num_feature])

  x.train.xgb <- data.matrix(x.train) # ���Ա���ת��Ϊ����
  dtrain<-list(data=x.train.xgb[,c(2:(num_feature-2))],label=x.train.xgb[,(num_feature-1)]*(-(-1)^(as.numeric(x.train.xgb[,num_feature]))))	#time*��-status�� Ϊɾʧ������Ϊ����
  Dtrain<-xgb.DMatrix(dtrain$data,label=dtrain$label)
  x.test.xgb <- data.matrix(x.test) # ���Ա���ת��Ϊ����
  dtest<-list(data=x.test.xgb[,c(2:(num_feature-2))],label=x.test.xgb[,(num_feature-1)]*(-(-1)^(as.numeric(x.test.xgb[,num_feature]))))	#time
  Dtest<-xgb.DMatrix(dtest$data,label=dtest$label)

### OUR MODEL
### ������ best_param ���Ҳ���lambda2

  best_param = list()
  best_loss = Inf
  best_loss_index = 0
  seed.number = 4321
  watchlist = list(train = Dtrain, test = Dtest)

  source("myobjtiaocan.R")
  my_xgb_param(best_param,best_loss,best_lost_index,seed.number,watchlist,fold, nthreads)

  ### ����lambda2
  load(file = sprintf("%d_my_xgb_result.RData",fold))
  source("xgbenc_2.R")
  xgbenc_param_2(x.train.xgb, result$best_param, result$nround, fold, nthreads)


}



## �õ�ƽ��ֵ
##5�۽�����֤����



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

##������֤�����ƽ��  ƽ��cindex��ƽ��auc����aucͼ
source("result_mean.R")
result_mean("my",result_my_1,result_my_2,result_my_3,result_my_4,result_my_5)
load("my_fin_result.RData")
my_fin_result = data_fin



######


my_fin_result$cindex

my_fin_result$auc_3
















