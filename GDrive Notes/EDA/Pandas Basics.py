import pandas as pd
import numpy as np

first_series = pd.Series(list('abcdefg'))
print(first_series)

city_series = pd.Series(np.array(['Luxembourg','Ireland','Singapore','Norway',
            'Qatar','United Arab Emirates','United States','Denmark','Sweden']))
print(city_series)

# By default index position will be auto-incremented with  start = 0, end = 8
# To change index position explicitly
city_series = pd.Series(np.array(['Luxembourg','Ireland','Singapore','Norway',
            'Qatar','United Arab Emirates','United States','Denmark','Sweden']),
            index=['a','b','c','d','e','f','g','h','i'])
print(city_series)

# collection of series
country_per_capita = {'Country':pd.Series(np.array(['Luxembourg','Ireland',
                'Singapore','Norway','Qatar','United States','Denmark','Sweden'])),
 'GDP_Per_Capita':pd.Series(np.array([142214, 126905, 127565, 114899,114648,
                                      76399,74005,64578]))
}

# Creating DataFrame using Collection of Series
GDP_DF = pd.DataFrame(country_per_capita)

# Display first 5 rows
print(GDP_DF.head())



