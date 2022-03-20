# Predicting Heartfailure using Machine-Learning in R

## Introduction
According to the World Health Organization reference in the world major diseases. Cardiovascular disease (CVDS) is one of the most serious diseases that cause people to die. In 2019, WHO data shows there are about 17.9 million people who died because of CVDS. Besides the 17.9 million people who died directly from the CVDs, 38% of people's cause of death has a close relationship with CVDs. Most of the CVDs can be avoided or relieved by diet control, behavioral adjustment, and other daily habits. Thus, CVDs become a horrible issue related to everyone, especially for those who work and study under huge pressures. (World Health Organization, 2021)

Heart failure is one of the most dangerous diseases under the CVDs category. Heart failure happens when the heart muscle occasionally loses function, and that directly causes the blood’s inability to pump to the lung and another part of the body. The patient will face breath shortness immediately if there is no blood in his lung. Most heart failure is irreversible, and 50% of patients will die in five years after they were diagnosed with heart failure. However, heart failure can be prevented by daily habits control and past medical history investigation. (World Health Organization, 2021)

The project objective is to use machine learning with heart failure patients’ data to check whether these 12 factors such as smoke, age, and sex will affect the heart failure death rate. Thus we can know what factors and history we need to pay attention to avoid heart failure and other potential CVDs.


## Data Summary
This dataset is from Davide Chicco, Giuseppe Jurman’s article writing about Cardiovascular diseases (Davide Chicco, Giuseppe Jurman, 2020).In this report, we analyze a dataset of 299 patients with heart failure collected in 2015. With the help of several machine learning classifications, we both predict the patient's survival, and rank the features corresponding to the most important risk factors. The dataset contains 13 features, which report clinical, body, and lifestyle information, that we briefly explained  below. Then  we represented this dataset as a table having 299 rows (patients) and 13 columns (features)(Davide Chicco, Giuseppe Jurman, 2020). 

**Variable Explanation**
*Age*: Age of the patient
*Anaemia*: Decrease of red blood cells or hemoglobin
*High blood pressure*: is a patient has hypertension
*Creatinine phosphokinase*: Level of the CPK enzyme in the blood
*Diabetes*: if the patients has diabetes
*Ejection Fraction*: Percentage of blood leaving the heart at each contraction
*Sex*: Woamn or man
*Platelets*: Platelets in the blood
*Serum creatinine*: Level of creatinine in the blood
*Serum sodium*: Level of sodium in the blood 
*smoking*: if the patient smokes
*Time*: Follow-up period
*(target)death event*: if the patients if the patient died during the follow-up period


## Methodologies
**Explonaratory Data Analysis**   
Demographic and Histology Distribution(see Exhibit 1) 
Lab Test Result Distribution (see Exhibit 2)  
Disease History Distribution (see Exhibit 3)  
Correlation Matrix
From the correlation matrix, it indicated the *Death Event is highly correlated with serum creatinine, age, serum sodium, ejection fraction.*


Based on this, we create a scatter plot to dive further into the correlations within those variables.(see scatter chart in the up right). We found that there are no variables highly correlated ( either positive or negative) with each other, which means we can take those independent variables into further analysis.



## Data Metrics
- mean individual income 
- median individual income
- standard deviation of individual income
- percentage of outliers: outliers of the two population who have extremelt high or extremely low income
- skewneww of individual income: refers to assymtery in the gaussian distribution of the two population samples, indicates the likelihood of an event falling in the tails of probability distribution.

## Data Source
[Oppurtunity Atlas](https://www.opportunityatlas.org)
 
## Data Analysis
We will use python to answer: what is the mean, median, standard deviation, percentage of outliers, skewness of the two population?

### Baltimore
- mean: 23248.80
- median: 22348.0
- standard deviation: 4761.92
- percentage of outliers: 1.16%
- skewness: -1.06
  
<img width="505" alt="Screen Shot 2020-11-22 at 22 22 13" src="https://user-images.githubusercontent.com/70663111/99926873-39a8f480-2d11-11eb-9029-042a871bc7bd.png">
The individual income of population in Baltimore is highly negatively skewed.



### Los Angeles
- mean: 26638.46
- median: 26183.0
- standard deviation: 4178.82
- percentage of outliers: 3.02%
- skewness: -0.96

<img width="461" alt="Screen Shot 2020-11-22 at 22 27 07" src="https://user-images.githubusercontent.com/70663111/99927042-e1262700-2d11-11eb-881a-b1f30d6c0b4d.png">
The individual income of population in Baltimore is moderately negatively skewed.


## Summary
In general, the mean and median of both population agree with the different living standards (income & expense level) in Baltimore and Los Angeles. Both cities have
larger median than mean because of outliers. In Baltimore, there is a smaller variety of individual income for those from lower socioeconomic class. It is more likely that a person's individual income is underperfoming compared
with her socioeconomic group in Baltimore than in Los Angeles despite the fact that the highest individual income from Baltimore is far greater than that of Los Angeles.

More analysis such as cluster analysis and linear regression can be used to find the possible cause and better compare the socioeconomic mobility in two cities.

## Python
1. Check head and tail and clean data by substracting rows with any empty element so following calculations can work.
2. Define an outlier function that detects outliers of the data.
3. Calculate population mean, variance, standard deviations, percentage of outlier.
4. Plot histogram of the two data sets.
5. Fit the data using with normal distribution and find the skewness of each population.
6. Print the results from step 3.
