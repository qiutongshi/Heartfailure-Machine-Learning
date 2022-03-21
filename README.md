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
<img width="638" alt="Screen Shot 2022-03-20 at 9 36 23 PM" src="https://user-images.githubusercontent.com/70663111/159195464-e5288122-47f8-44a3-b25a-27fda2748489.png">

Based on this, we create a scatter plot to dive further into the correlations within those variables.(see scatter chart in the up right). We found that there are no variables highly correlated ( either positive or negative) with each other, which means we can take those independent variables into further analysis.

**Logistic Regression**  
After learning about the relationships between independent variables, we selected all variables as the predictors and randomly selected training and testing data sets to perform and verify a logistic regression model that helps us understand the impacts of the variables on variable DEATH_EVENT. The difference between residual deviance and null deviance has shown the variables have improved the effectiveness of this model. 

<img width="381" alt="Screen Shot 2022-03-20 at 9 36 35 PM" src="https://user-images.githubusercontent.com/70663111/159195471-b48c8c53-a800-49dd-b929-6783adca1617.png">

We used the logistic regression model to predict the probability that one will die, for each person in the testing data set. To better understand who should be warned about their risk in having death caused by heart failures, we tried to classify the predictions as “risk” or “mild risk” using a threshold that provides the best accuracy. By cross-tabulating our predictions with respect to actual DEATH_EVENT, we find that the differences between the accuracies of the three potential thresholds are very small. 

<img width="622" alt="Screen Shot 2022-03-20 at 9 36 46 PM" src="https://user-images.githubusercontent.com/70663111/159195482-82b554bd-819d-45c1-a87c-53758c1a7ff5.png">

**K-Nearest Neighbor**  
In this part, we use K-Nearest Neighbors(KNN) to get our prediction about whether a person with specific characters is likely to die. The reason we choose KNN is that we do not have assumptions on the model before we make our prediction, which helps us gain more flexible predictions. In our experiment, we use “age”, “anaemia”, “creatinine_phosphosphokinase”, “diabetes”, “ejection_fraction”, “high_blood_pressure”, “platelets”, “serum_creatinine”, “serum_sodium”, “sex”, “smoking”, and “time” as our predictors and our prediction Y is “DEATH_EVENT”, where “1” stands for death and “0” stands for living. Then we randomly select half of the data as training data and the rest as test data. We have examined k from 1 to 12 and checked each model’s accuracy to find the best model. The following is our output:  

From the result, we get the best KNN model that is 68 percent accurate when K=9. Every time we have a new patient and his detailed data, we can put the data into this model, then R will find 9 closest neighbors in our training data and give us a predicted result. However, this model still needs to be refined to improve its accuracy if we want to use it in real life. 

<img width="628" alt="Screen Shot 2022-03-20 at 9 36 56 PM" src="https://user-images.githubusercontent.com/70663111/159195491-69c98960-5d37-40df-a947-7eebfdafac79.png"> 

**Decision Trees**  
We also use the decision tree to conduct our prediction about whether a person will die, which is easier to explain and understand. In this process, we randomly select half of the data as training data and the rest as test data. The predictors are the same as 12 predictors we used in our KNN model, but the output is DEATH, in which “Yes” stands for death and “No” stands for living. At first, we created a decision tree: 

<img width="673" alt="Screen Shot 2022-03-20 at 9 37 08 PM" src="https://user-images.githubusercontent.com/70663111/159195502-fe708768-2e0a-431f-aeef-c1196a60484a.png">

Exam accuracy using test data: 

<img width="626" alt="Screen Shot 2022-03-20 at 9 37 21 PM" src="https://user-images.githubusercontent.com/70663111/159195510-116d166f-8ab4-48ba-b5d1-c187c9636b49.png">

In order to avoid the overfitting problem and get a smaller tree for people to use, we use the cross-validation method to prune this initial decision tree. During this process, we find that when the size=5, we have the smallest deviation, which means our best decision tree has a size of 6. 

<img width="486" alt="Screen Shot 2022-03-20 at 9 37 33 PM" src="https://user-images.githubusercontent.com/70663111/159195515-aaafed6b-a513-4338-8dd9-ed9473e008c6.png">

Then we print this decision tree and examine its accuracy:

<img width="546" alt="Screen Shot 2022-03-20 at 9 37 46 PM" src="https://user-images.githubusercontent.com/70663111/159195527-937f1245-d821-4c79-823e-a8e78a70adb1.png">



## Summary
In this project, we used three different methods to analyze heart failure data. Using K-Nearest Neighbors, we obtain the best model when k=9, which has 68 percent accuracy. Then we use decision trees, which can analyze data and present the prediction process in visualization. After pruning our initial tree, the final decision tree can reach 80 percent accuracy. In the following part, we conduct logistic regression to analyze which variables have greater influence on people’s death, which gives our project a more practical meaning. This result can be used in the medical field to guide patients’ behaviors.

From the logistic regression, we have 90% confidence that variables age, anaemia, creatinine_phosphokinase, ejection fraction, platelets, serum_creatinine, and time are statistically significant. Using the logistic regression model, we predict the probability that one will die, for each day in the testing data. We classify prediction as “risky” if the probability >30%, and “mild risk” otherwise since its accuracy only differs from 50% and 70% within 0.010. We hope that this model can help warn patients that have a high potential risk of death caused by heart failures. 



## Reference
Davide Chicco, Giuseppe Jurman: Machine learning can predict survival of patients with heart failure from serum creatinine and ejection fraction alone. BMC Medical Informatics and Decision Making 20, 16 (2020). (link)t-sheets/detail/cardiovascular-diseases-(cvds) 
World Health Organization. (n.d.). Cardiovascular diseases (cvds). World Health Organization. Retrieved December 18, 2021, from https://www.who.int/news-room/fac

## Appendix
-  Exhibit 1 

<img width="643" alt="Screen Shot 2022-03-20 at 9 37 58 PM" src="https://user-images.githubusercontent.com/70663111/159195534-de1dc852-7e86-4843-932f-8ca25b00a62b.png">

- Exhibit 2 

<img width="661" alt="Screen Shot 2022-03-20 at 9 38 22 PM" src="https://user-images.githubusercontent.com/70663111/159195550-88ca0ec4-c013-457f-8ddf-1205f5ad2aed.png">

- Exhibit 3 

<img width="656" alt="Screen Shot 2022-03-20 at 9 38 32 PM" src="https://user-images.githubusercontent.com/70663111/159195557-e08028e7-00b9-494b-b4ce-0527775dc431.png">

