cross_va_sample <- function(x,seed,fold){

xalive <- which(x$status==0)
xdead <- which(x$status==1)

####��������

x.alive <- x[xalive,]
n.alive<-nrow(x.alive)	#�еĸ���346
n.alive	 #346
k.alive <- rep((1:5), 225)[1:n.alive]
k.alive	#1��3�ظ�120��(���յõ�564����

set.seed(seed)
i.alive <- sample(k.alive, size=n.alive, replace = FALSE)	#���Żص������������k�г�ȡ346��Ԫ��
#i.alive
k.alive.test <-(1:n.alive)[i.alive==fold]
k.alive.test			#�����Լ���115��,ѵ������115*2����
x.alive.train <- x.alive[(-k.alive.test),]
dim(x.alive.train)                  #ѵ���� 231*19757
x.alive.test <- x.alive[(k.alive.test),]
dim(x.alive.test)                   #��֤�� 115*19757

a=dim(x)[2]
t.alive.train <- x.alive[(-k.alive.test),a-1]    #ʱ��
t.alive.test <- x.alive[(k.alive.test),a-1]
s.alive.train <- x.alive[(-k.alive.test),a]   #״̬
s.alive.test <- x.alive[(k.alive.test),a]

####��������

x.dead <- x[xdead,]
n.dead<-nrow(x.dead)	#�еĸ���346
n.dead	 #346
k.dead <- rep((1:5), 125)[1:n.dead]
k.dead	#1��3�ظ�120��(���յõ�564����

set.seed(seed)
i.dead <- sample(k.dead, size=n.dead, replace = FALSE)	#���Żص������������k�г�ȡ346��Ԫ��
#i.dead
k.dead.test <-(1:n.dead)[i.dead==fold]
k.dead.test			#�����Լ���115��,ѵ������115*2����
x.dead.train <- x.dead[(-k.dead.test),]
dim(x.dead.train)                  #ѵ���� 87*15536
x.dead.test <- x.dead[(k.dead.test),]
dim(x.dead.test)                   #��֤�� 43*15536


##### ���� <- ���棺�������

x.train <- rbind(x.alive.train, x.dead.train)
x.train <- as.data.frame(x.train)
x.test <- rbind(x.alive.test, x.dead.test)
x.test <- as.data.frame(x.test)
write.table(x.train,file="x.train.txt",row.names=TRUE,col.names=TRUE,append=FALSE,sep="\t")
write.table(x.test,file="x.test.txt",row.names=TRUE,col.names=TRUE,append=FALSE,sep="\t")

}





