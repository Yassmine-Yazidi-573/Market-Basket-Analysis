install.packages("arules")
install.packages("arulesViz")
library(arules)
library(arulesViz)
groceries=read.transactions("groceries - groceries.csv", sep=',') # building a sparse matrix out of the transactions
summary(groceries)
# transactions as itemMatrix in sparse format with
#9835 rows (elements/itemsets/transactions) and
#169 columns (items) and a density of 0.02609146
inspect(groceries[1:3])
#items                                                      
#[1] {citrus fruit, margarine, ready soups, semi-finished bread}
#[2] {coffee, tropical fruit, yogurt}                           
#[3] {whole milk} 
itemFrequency(groceries[,1:3])
#abrasive cleaner artif. sweetener   baby cosmetics 
#0.0035587189     0.0032536858     0.0006100661
#it calculates the support of the specified columns(items) in the sparse matrix groceries
itemFrequencyPlot(groceries, support=0.1)#
# the plot shows the 8 items with at least 10% support
itemFrequencyPlot(groceries, topN=20)
# plots the frequency of top 20 items (in decreasing way:  from most frequent to least frequent)
image(groceries[1:5])
#it plots a matrix of 5 rows(transactions) and multiple columns(169 items)
#black dots/squares in the image = item purchased
image(sample(groceries,100))
# same as previous step but this time with 100 randomly selected transactions
# PERFORMING THE APRIORI ALGO
rul=apriori(groceries, parameter = list(support=0.006, confidence=0.25, minlen=2))
rul
#set of 463 rules
# MODEL EVALUATION
summary(rul)
inspect(rul[1:3])
#lhs                    rhs               support     confidence coverage   lift     count
#[1] {potted plants} => {whole milk}      0.006914082 0.4000000  0.01728521 1.565460 68   
#[2] {pasta}         => {whole milk}      0.006100661 0.4054054  0.01504830 1.586614 60   
#[3] {herbs}         => {root vegetables} 0.007015760 0.4312500  0.01626843 3.956477 69 
#the rul (1) covers 0.69% of transactions with a confidence of 40%
inspect(sort(rul, by="lift")[1:4])
#lhs                        rhs                      support confidence   coverage     lift count
#[1] {herbs}             => {root vegetables}    0.007015760  0.4312500 0.01626843 3.956477    69
#[2] {berries}           => {whipped/sour cream} 0.009049314  0.2721713 0.03324860 3.796886    89
#[3] {other vegetables,                                                                          
#  tropical fruit,                                                                            
#  whole milk}        => {root vegetables}    0.007015760  0.4107143 0.01708185 3.768074    69
#[4] {beef,                                                                                      
#  other vegetables}  => {root vegetables}    0.007930859  0.4020619 0.01972547 3.688692    78
berry_rul=subset(rul,items %in% "berries")
inspect(berry_rul)
#lhs              rhs                  support     confidence coverage  lift     count
#[1] {berries} => {whipped/sour cream} 0.009049314 0.2721713  0.0332486 3.796886  89  
#[2] {berries} => {yogurt}             0.010574479 0.3180428  0.0332486 2.279848 104  
#[3] {berries} => {other vegetables}   0.010269446 0.3088685  0.0332486 1.596280 101  
#[4] {berries} => {whole milk}         0.011794611 0.3547401  0.0332486 1.388328 116 
plot(rul)
plot(rul, measure=c("support","lift"), shading="confidence")
plot(rul, measure=c("confidence","lift"), shading="support")
rul2=head(rul, n=10, by="lift")
plot(rul2, method="graph")
plot(rul2,method="paracoord")
plot(rul2, method="matrix")
plot(rul2, method="graph", engine="htmlwidget")
