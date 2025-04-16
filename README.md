# 🛒 Market Basket Analysis with Apriori Algorithm in R

This project performs Market Basket Analysis on a grocery dataset using the **Apriori algorithm**, implemented through the `arules` and `arulesViz` R packages.

---

## 📦 Installation

To run this script, you'll need to install the required R packages:

```r
install.packages("arules") 
install.packages("arulesViz")
```

---

## 📚 Libraries Used

```r
library(arules)
library(arulesViz)
```

---

## 📂 Dataset

The dataset used is `groceries - groceries.csv`, which contains 9,835 transactions and 169 unique grocery items.

---

## 🔍 Steps Performed

### 1. 📥 Data Loading & Summary

- The transactions are read and converted into a **sparse matrix**:
  ```r
  groceries = read.transactions("groceries - groceries.csv", sep=',')
  summary(groceries)
  ```

### 2. 🔎 Exploring Transactions

- View the first few transactions:
  ```r
  inspect(groceries[1:3])
  ```

- Analyze item frequency:
  ```r
  itemFrequency(groceries[,1:3])
  ```

- Visualize frequent items:
  ```r
  itemFrequencyPlot(groceries, support=0.1)
  itemFrequencyPlot(groceries, topN=20)
  ```

- Visualize transaction matrices:
  ```r
  image(groceries[1:5])
  image(sample(groceries, 100))
  ```

---

### 3. 🤖 Apriori Algorithm

- Run the algorithm with specified parameters:
  ```r
  rul = apriori(groceries, parameter = list(support=0.006, confidence=0.25, minlen=2))
  ```

- View a summary and inspect the rules:
  ```r
  summary(rul)
  inspect(rul[1:3])
  ```

- Sort rules by lift:
  ```r
  inspect(sort(rul, by="lift")[1:4])
  ```

- Extract rules related to specific items:
  ```r
  berry_rul = subset(rul, items %in% "berries")
  inspect(berry_rul)
  ```

---

### 4. 📊 Visualization

- Basic plots of rules:
  ```r
  plot(rul)
  ```

- Advanced plots:
  ```r
  plot(rul, measure=c("support","lift"), shading="confidence")
  plot(rul, measure=c("confidence","lift"), shading="support")
  ```

- Focused visualizations on top rules:
  ```r
  rul2 = head(rul, n=10, by="lift")
  plot(rul2, method="graph")
  plot(rul2, method="paracoord")
  plot(rul2, method="matrix")
  plot(rul2, method="graph", engine="htmlwidget")
  ```

---

## 📝 Notes

- **Support** indicates how frequently items appear together in the dataset.
- **Confidence** measures how often a rule has been found to be true.
- **Lift** evaluates how much more likely item B is bought when item A is bought, compared to its default purchase rate.

---

## ✅ Output Highlights

- 463 association rules were generated.
- Example Rule: `{pasta} => {whole milk}`  
  - Support: 0.0061  
  - Confidence: 40.5%  
  - Lift: 1.58

---

## 📈 Applications

- This analysis can help retailers:
  - Optimize store layouts
  - Offer targeted promotions
  - Improve product recommendations
