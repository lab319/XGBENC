
rm(list=ls())
gc()

cli_rna <- function(clinical){
######################�����ٴ�����##################################

dim(clinical)   #508*227
names(clinical)
#head(clinical)
clinical <- clinical[,c(1,2,3)] ##�ֱ�Ϊ ��š�����ʱ�䡢����״̬
#clinical <- clinical[,c(1,2,3,7,8,9,36)]    #ȥ��ȱʧֵ�ܶ����
names(clinical)
dim(clinical)                        #528*3
clinical[clinical==""]<-NA		#��NA�滻�հ�ֵ
dim(clinical)
head(clinical)
clinical <- na.omit(clinical)		#ɾ������NA����
colnames(clinical)[1] <- "Tags"
colnames(clinical)[2] <- "time"
colnames(clinical)[3] <- "status"


dim(clinical)   #507*3            #ֻҪ����NA���Ͱ��������ȥ����ʣ��495
#View(clinical)
head(clinical)

clinical[,1] <- paste(substr(clinical[,1],0,4),substr(clinical[,1],6,7),substr(clinical[,1],9,12),sep=".")

#View(clinical)

#######���ٴ������е������ͱ��������ֵ�ͱ���
clinical$status
index_Alive=which(as.character(clinical$status)=="Alive")
index_Dead=which(as.character(clinical$status)=="Dead")
clinical$status=NA
clinical$status[index_Alive]=0
clinical$status[index_Dead]=1
clinical$status

#View(clinical)
write.table(clinical,file="clinical.txt",row.names=FALSE,col.names=TRUE,append=FALSE,sep="\t")

#################��ȡ���ٰ���RNA-Seq��������,�������ݺ��ٴ������󽻼�###############

RNA <- read.table(file='TCGA RNA log2.txt',header=T,sep="\t")
dim(RNA)	#15936*506  ���ǻ���  ��������
dim(clinical)	#457*3

colnames(RNA)[1] <- "Tags"
head(RNA[1:5,1:5])
head(clinical)

RNA1<-t(RNA)     #��������  ��������
RNA1=as.data.frame(RNA1)
head(RNA1[1:5,1:5])

write.table(RNA1,file="RNAδɾ����.txt",row.names=TRUE,col.names=FALSE,append=FALSE,sep="\t")
rm(list=ls())
clinical <- read.table(file="clinical.txt",T)
RNA2 <- read.table(file="RNAδɾ����.txt",T)    #��������  ��������

a = which(substr(RNA2[,1],13,15)==".01")

RNA2 <- RNA2[a,]

RNA2[,1] <- substr(RNA2[,1],0,12)
dim(RNA2)		#462*15937
head(RNA2[1:5,1:5])

#id <- as.character(RNA2$Tags)
#id
#newid=substr(id,1,12)
#newid
#RNA2$Tags <- newid
#RNA2$Tags
#RNA2$Tags <- as.factor(RNA2$Tags)
#RNA2$Tags			#513 levels

#head(RNA2[1:5,1:5])
#dim(RNA2)		#533*24992
head(clinical)
head(RNA2[1:5,1:5])
#dim(data)		#495*6

#########################################

jiaoji <- merge(RNA2,clinical,by = 'Tags')
dim(jiaoji)			#497*16323
head(jiaoji[1:5,1:5])
write.table(jiaoji,file="�ϲ�.txt",row.names=FALSE,col.names=TRUE,append=FALSE,sep="\t")
rm(a)
rm(jiaoji)
gc()
f <- read.table(file="�ϲ�.txt",T)
g <- t(f)
h <- as.data.frame(g)
dim(h)		#16761*496
head(h[1:5,1:5])
write.table(h,file="�ϲ�_�л���������.txt",row.names=TRUE,col.names=FALSE,append=FALSE,sep="\t")
rm(list=c("f","g","h"))
m <- read.table(file="�ϲ�_�л���������.txt",T)
num_feature = dim(m)[1]		#16760*497
num_sample = dim(m)[2]
head(m[1:5,1:5])
#View(m[(num_feature-3):num_feature,1:5])
xcli <- m[c((-1):(-(num_feature-2))),]	#���ٴ�
dim(xcli)               #2*497
head(xcli[,1:5])
xcli2 <- t(xcli)
xcli2 <- as.data.frame(xcli2)
head(xcli2[1:5,])
write.table(xcli2,file="TCGA clinical data.txt",row.names=TRUE,col.names=FALSE,append=FALSE,sep="\t")
#x3 <- read.table(file="TCGA clinical data.txt",T)      #####���ں����������ٴ�����
#dim(x3)       #488*7
#names(x3)
#head(x3[1:5,1:5])

RNA3 <- m[c((-(num_feature-1)):(-num_feature)),]  ##����������
dim(RNA3)			#16758*497
head(RNA3[(num_feature-4):num_feature,1:5])
write.table(RNA3,file="RNA_�л���������.txt",row.names=FALSE,col.names=TRUE,append=FALSE,sep="\t")

RNA4 <- read.table(file='RNA_�л���������.txt',header=T)
RNA4 <- t(RNA4)
RNA4 = as.data.frame(RNA4)
dim(RNA4)		#347*19754
head(RNA4[1:5,1:5])
class(RNA4)
write.table(RNA4,file="TCGA RNA data.txt",row.names=TRUE,col.names=FALSE,append=FALSE,sep="\t")   #####���ں��������ķ�������

}

