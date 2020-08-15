#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
from sklearn import metrics
import matplotlib.pyplot as plt 
from sklearn.linear_model import LogisticRegression


# In[4]:


test_data = pd.read_csv('/Users/shubh/Desktop/Completed Courses/Predictive Analytics/Week 2/MNIST-data/mnist_test.csv', header=None)
train_data = pd.read_csv ('/Users/shubh/Desktop/Completed Courses/Predictive Analytics/Week 2/MNIST-data/mnist_train.csv', header=None)


# In[5]:


#for col in test_data.columns:
 #   print(type(col))


# In[6]:


train_data['flag_0'] = (train_data[0].map(lambda x: x == 0)).astype(int)
train_data['flag_1'] = (train_data[0].map(lambda x: x == 1)).astype(int)
train_data['flag_2'] = (train_data[0].map(lambda x: x == 2)).astype(int)
train_data['flag_3'] = (train_data[0].map(lambda x: x == 3)).astype(int)
train_data['flag_4'] = (train_data[0].map(lambda x: x == 4)).astype(int)
train_data['flag_5'] = (train_data[0].map(lambda x: x == 5)).astype(int)
train_data['flag_6'] = (train_data[0].map(lambda x: x == 6)).astype(int)
train_data['flag_7'] = (train_data[0].map(lambda x: x == 7)).astype(int)
train_data['flag_8'] = (train_data[0].map(lambda x: x == 8)).astype(int)
train_data['flag_9'] = (train_data[0].map(lambda x: x == 9)).astype(int)


# In[7]:


print(train_data.head())


# In[8]:


train_data.rename(columns={0:'Labels'})


# In[9]:


df1 = pd.DataFrame({}) 
#print(type(df1))


# In[10]:


def LogisticR(trainx, trainy, testx, i):
    LR = LogisticRegression()
    LR.fit(trainx, trainy)
    predictions = LR.predict_proba(testx)
    lst2 = [item[1] for item in predictions]
    return lst2


# In[11]:


x_0 = LogisticR(train_data.iloc[0:, 1:785], train_data.iloc[0:, 785], test_data.iloc[:-1, 1:], 0)
x_1 = LogisticR(train_data.iloc[0:, 1:785], train_data.iloc[0:, 786], test_data.iloc[:-1, 1:], 1)
x_2 = LogisticR(train_data.iloc[0:, 1:785], train_data.iloc[0:, 787], test_data.iloc[:-1, 1:], 2)
x_3 = LogisticR(train_data.iloc[0:, 1:785], train_data.iloc[0:, 788], test_data.iloc[:-1, 1:], 3)
x_4 = LogisticR(train_data.iloc[0:, 1:785], train_data.iloc[0:, 789], test_data.iloc[:-1, 1:], 4)
x_5 = LogisticR(train_data.iloc[0:, 1:785], train_data.iloc[0:, 790], test_data.iloc[:-1, 1:], 5)
x_6 = LogisticR(train_data.iloc[0:, 1:785], train_data.iloc[0:, 791], test_data.iloc[:-1, 1:], 6)
x_7 = LogisticR(train_data.iloc[0:, 1:785], train_data.iloc[0:, 792], test_data.iloc[:-1, 1:], 7)
x_8 = LogisticR(train_data.iloc[0:, 1:785], train_data.iloc[0:, 793], test_data.iloc[:-1, 1:], 8)
x_9 = LogisticR(train_data.iloc[0:, 1:785], train_data.iloc[0:, 794], test_data.iloc[:-1, 1:], 9)

df1 = pd.DataFrame({'l0':x_0, 'l1':x_1,'l2':x_2, 'l3':x_3,'l4':x_4, 'l5':x_5, 'l6':x_6, 'l7':x_7, 'l8':x_8, 'l9':x_9}) 

print(df1)


# In[12]:


def softmax(x):
    e_x = np.exp(x - np.max(x))
    vals =  e_x / e_x.sum(axis=0)
    l = vals.tolist()
    j = l.index(max(l))
    return np.max(j)


# In[13]:


# Iterate over each row
Target_list =[] 
for index, rows in df1.iterrows(): 
    my_list =[rows.l0, rows.l1, rows.l2, rows.l3, rows.l4, rows.l5, rows.l6, rows.l7, rows.l8, rows.l9] 
    hg = softmax(my_list)
    Target_list.append(hg)
    #print(hg)  
 


# In[14]:


#Target_list


# Confusion Matrix

# In[15]:


confusionM = metrics.confusion_matrix(test_data.iloc[:-1, 0], Target_list)
print(confusionM)


# In[23]:


plt.figure(figsize=(9,9))
plt.imshow(confusionM, interpolation='nearest', cmap='OrRd')
plt.title('Confusion matrix', size = 15)
plt.colorbar()
tick_marks = np.arange(10)
plt.xticks(tick_marks, ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"], rotation=45, size = 10)
plt.yticks(tick_marks, ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"], size = 10)
plt.tight_layout()
plt.ylabel('Actual label', size = 15)
plt.xlabel('Predicted label', size = 15)
width, height = confusionM.shape
for x in range(width):
 for y in range(height):
  plt.annotate(str(confusionM[x][y]), xy=(y, x), 
  horizontalalignment='center',
  verticalalignment='center')


# Accuracy of the model

# In[17]:


diagonal_sum = confusionM.trace()
sum_of_all_elements = confusionM.sum()
accuracy = diagonal_sum / sum_of_all_elements 
print(accuracy)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




