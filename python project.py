import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

df = pd.read_csv(r'C:\Users\dell\OneDrive\Desktop\project\movies.csv')
pd.set_option('display.max_columns', None)  # show all columns
pd.set_option('display.width', None)        # don't wrap
#print(df['budget'])
#print(df['gross'])
#print(df.head())

#for col in df.columns:
#   cal = np.mean(df[col].isnull())
# print('{} - {}%'.format(col,cal))
#print(df.dtypes
#print(df['budget'].unique())
#df['budget']=df['budget'].fillna(0).astype('int64')
#print(df['budget'])
#df['gross']= df['gross'].fillna(0).astype('int64')
#print(df['gross'])
#print(df['gross'])
#print(df['gross'].unique())
#print(df['year'])
#print(df['released'])
#df['correctyear']=df['released'].astype('string').str[12:]
#print(df['correctyear'])
#print(df.head())
#pd.set_option('display.max_rows',None)
#print(df.sort_values(by =['gross'], inplace=False,ascending=False))
#df['company'].drop_duplicates().sort_values(ascending=False)
#print(df['company'])

#plt.scatter(x=df['budget'] , y=df['gross'],color='orange')
#plt.title('budget vs gross')
#plt.xlabel('budget')
#plt.ylabel('gross')
#plt.show()
#print(df.head())

sns.regplot(x='budget',y = 'gross', data=df, scatter_kws={"color":"yellow"},line_kws={'color':'b'})
#plt.show()
a = df.corr(method='spearman', numeric_only=True)
sns.heatmap(a,annot=True)
plt.title("correlation matrix for numeric features")
plt.xlabel("movie feature")
plt.ylabel("budget for films")
#plt.show()
df.head()
#print(df)


b = df
for col in b.columns:
    if (b[col].dtype=='object'):
        b[col]=b[col].astype('category')
        b[col]=b[col].cat.codes
#print(b)

#print(df)
a = b.corr(method='spearman', numeric_only=True)
sns.heatmap(a,annot=True)
plt.title("correlation matrix for numeric features")
plt.xlabel("movie feature")
plt.ylabel("budget for films")
#plt.show()


unstack = b.corr().unstack()
sort= unstack.sort_values()
high_corr = sort[(sort)>0.5]
print(high_corr)





