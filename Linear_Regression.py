# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score,mean_squared_error
"%matplotlib inline"
#setwd = 'C:/Users/shubh/Desktop/Intermediate Analytics/Week 5/cardataset/' 
df = pd.read_csv('C:/Users/shubh/Desktop/Completed Courses/Intermediate Analytics/Week 5/cardataset/data.csv') # Importing the dataset
#df.sample(5) #previewing dataset randomly
print(df.sample(4)) #previewing dataset randomly
print(df.shape)
print(df['Make'].value_counts())
new_df = df[df['Make']=='Volkswagen'] #in this new dataset we only take 'Volkswagen' cars
print(new_df.shape) #Viewing the new dataset shape
print(new_df.isnull().sum()) #Is there any NULL or empty cell present
new_df = new_df.dropna() #Deleting the rows which have empty cells
print(new_df.shape) #After deletion viewing the shape
print(new_df.isnull().sum()) #Is there any NULL or empty cell present
new_df.sample(2) #checking the random dataset sample
new_df = new_df[['Engine HP','MSRP']] #We only take the 'Engine HP' and 'MSRP' columns
new_df.sample(5) #checking the random dataset sample
X = np.array(new_df[['Engine HP']]) #Storing into X the 'Engine HP' as np.array
Y = np.array(new_df[['MSRP']])#Storing into y the 'MSRP' as np.array
print(X.shape) #Viewing the shape of X
print(Y.shape) #Viewing the shape of Y
plt.scatter(X,Y,color="red") #Plot a graph X vs Y
plt.title('HP vs MSRP')
plt.xlabel('HP')
plt.ylabel('MSRP')
plt.show()
X_train,X_test,Y_train,Y_test = train_test_split(X,Y,test_size = 0.25,random_state=15) #Spliting into train & test dataset
regressor = LinearRegression() #Creating a regressior 
regressor.fit(X_train,Y_train) #Fiting the dataset into the model
plt.scatter(X_test,Y_test,color="green") #Plot a graph with X_test vs Y_test
plt.plot(X_train,regressor.predict(X_train),color="red",linewidth=3) #Regressior line showing 
plt.title('Regression(Test Set)')
plt.xlabel('HP')
plt.ylabel('MSRP')
plt.show()
plt.scatter(X_train,Y_train,color="blue") #Plot a graph with X_train vs Y_train
plt.plot(X_train,regressor.predict(X_train),color="red",linewidth=3) #Regressior line showing
plt.title('Regression(training set)')
plt.xlabel('HP')
plt.ylabel('MSRP')
plt.show()
y_pred = regressor.predict(X_test)
print('R2 score: %.2f' %r2_score(Y_test,y_pred)) #Printing R2 Score
print('Mean squared Error:',mean_squared_error(Y_test,y_pred)) #Printing the mean error
def car_price(hp): #Afunction to predict the price acording to Horsepower
    result = regressor.predict(np.array(hp).reshape(1,-1))
    return(result[0,0])
    
car_hp = int(input('Enter Volkswagen cars Horse Power:'))
print('The Volkswagen Price will be: ',int(car_price(car_hp)),'$')    