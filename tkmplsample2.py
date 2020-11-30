"""
sample of py script that using non std lib (matplotlib as ex)
"""

#%%
import matplotlib.pyplot as plt
import matplotlib as mpl
import math  

q=100
X=[ ((x-q/2)*.1 ) for x in range(q)]
plt.plot( X, [math.sin(x) for x in X] )
plt.plot( X, [-math.sin(x) for x in X] )
plt.plot( X, [x*.25 for x in X] )
plt.plot( X, [-x*.25 for x in X] )
plt.show()
 
#%%