import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

#Money evolution
column = ["Money"]

df1 = pd.read_csv('player1_test_2pl_money.csv', usecols = column)
df2 = pd.read_csv('player2_test_2pl_money.csv', usecols = column)

#Reverses dataframes
df1 = df1[::-1].reset_index()
df2 = df2[::-1].reset_index()

#Plots money evolution
plt.plot(df1['Money'], label = "Joueur 1")
plt.plot(df2['Money'], label = "Joueur 2")


#Plots floor
plt.axhline(y=0, linewidth = 2,  color='r', linestyle = 'dotted', label = "Plancher")

#Names axis
plt.ylabel("Argent")

plt.legend()
plt.show()
