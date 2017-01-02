

#构造邻接矩阵(方阵):
mymatrix <- matrix(c(0,0,0,0, 1,0,0,1, 1,1,0,0, 1,1,1,0), nrow =4, ncol=4, byrow=TRUE)


#t = mymatrix[1,]+ mymatrix[2,] +mymatrix[3,]+ mymatrix[4,]

#for(i in 1:4){ mymatrix[i,] <- mymatrix[i,]/t }


data<-data.frame(mymatrix)

data <-t(data)

colnames(data)<-c("X1","X2","X3","X4")

library(reshape)

md <- melt(data, id=(c("X1")))

md <- subset(md, value>0)[,c(1,2)]


#PageRank算法R语言实践
####################################################################################

第一步：加载R包
####################################################################################

library(igraph)




第二步：生成有向图
####################################################################################

g <- graph.data.frame(md )


第三步：画有向图
####################################################################################

plot(g)


第四步：计算PageRank
####################################################################################

pr <-page.rank(g)$vector



第五步：显示每个对象的 PageRank
####################################################################################

df <-data.frame(Object =1:4,PageRank = pr)

#install.packages("dplyr")
library(dplyr) #arrange()源于dplyr包
arrange(df,desc(PageRank))




a <- sample(1:15, size = 10)

b <- sample(1:5, size = 10)

b <- round(runif(1,3,10))

md <- data.frame(a,b)

g <- graph.data.frame(md )

plot(g)

round(runif(1,3,6))




