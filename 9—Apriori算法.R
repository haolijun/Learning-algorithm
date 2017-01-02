#本文介绍Apriori算法在R语言中如何使用。

#数据集采用arules包中的Adult数据集。

#Adult数据集属于事务型数据集。
 
#Apriori算法R语言实践
#############################################################################################################

#第一步：加载实现Apriori算法的R包
#############################################################################################################

#install.packages("arules")
library(arules)
data("Adult")

#View(as(Adult,"data.frame")[1,1])   #看事务型数据集中的数据
#{age=Middle-aged,workclass=State-gov,education=Bachelors,marital-status=Never-married,occupation=Adm-clerical,relationship=Not-in-family,race=White,sex=Male,capital-gain=Low,capital-loss=None,hours-per-week=Full-time,native-country=United-States,income=small}

#第二步：利用Apriori算法构建关联规则模型
#############################################################################################################

rules.Apriori <-apriori(Adult,parameter =list(support=0.4,confidence=0.7), appearance=list(rhs=c("race=White", "sex=Male"), default="lhs"))

#第三步：利用提升度对规则排序，获取前top-5项
#############################################################################################################

rules.sorted <-sort(rules.Apriori,by="lift")
top5.rules <-head(rules.sorted, 5)
as(top5.rules,"data.frame")
 

#Apriori算法原理
#############################################################################################################

#1 Apriori算法是种最有影响的挖掘布尔关联规则频繁项集的算法。它的核心是基于两阶段频集思想的递推算法。
#该关联规则在分类上属于单维、单层、布尔关联规则。在这里，所有支持度大于最小支持度的项集称为频繁项集。

#思考：Apriori算法如何寻找频繁项集？对于大规模数据，Apriori算法会有什么表现？？


#example
library(arules)
data(Groceries)
summary(Groceries)

#超过5%的顾客购买的商品名字和频率
itemFrequencyPlot(Groceries,support = 0.15, cex.names=0.8)
 
as(Groceries[1:12],"data.frame")

fsets <- eclat(Groceries,parameter=list(support=0.05,maxlen=10))
inspect(fsets[1:10])

inspect(sort(fsets,by="support")[1:10])

rules = apriori(Groceries,parameter = list(support=0.01,confidence=0.01)) #求规则
x=subset(rules,subset=rhs %in% "whole milk" &lift>1.2)

#如果把whole milk 作为右项，支持度最高的五个规则为：这个结果表明，other vegetables 和 whole milk 同时购买的频率最高，商家可以依据这个信息对货架或宣传进行合理安排
inspect(sort(x,by="support")[1:5])

#如果把whole milk 作为右项，置信度最高的五个规则为：
inspect(sort(x,by="confidence")[1:5])
#    lhs                                 rhs          support    confidence lift    
#[1] {curd,yogurt}                    => {whole milk} 0.01006609 0.5823529  2.279125
#[2] {other vegetables,butter}        => {whole milk} 0.01148958 0.5736041  2.244885
#[3] {tropical fruit,root vegetables} => {whole milk} 0.01199797 0.5700483  2.230969
#[4] {root vegetables,yogurt}         => {whole milk} 0.01453991 0.5629921  2.203354
#[5] {other vegetables,domestic eggs} => {whole milk} 0.01230300 0.5525114  2.162336

#前面提到，买whole milk 的人占总顾客人数的26%。因此，如果在人群中推销whole milk，则可能只有26%的人响应
#而如果在购买curd和yogurt的人群中促销，则可能58%（confidence）的顾客会响应，是在整个人群中促销效率的约2.28倍（lift）

#如果把whole milk 作为右项，lift(提升)的最高的五个规则为：
inspect(sort(x,by="lift")[1:5])



