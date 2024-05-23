import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

#-----Money evolution-----
column = ["Money"]

money_pl1 = pd.read_csv('player1_test_2pl_money.csv', usecols = column)
money_pl2 = pd.read_csv('player2_test_2pl_money.csv', usecols = column)

#Reverses dataframes
money_pl1 = money_pl1[::-1].reset_index()
money_pl2 = money_pl2[::-1].reset_index()

#Plots money evolution
plt.plot(money_pl1['Money'], label = "Joueur 1")
plt.plot(money_pl2['Money'], label = "Joueur 2")


#Plots floor
plt.axhline(y=0, linewidth = 2,  color='r', linestyle = 'dotted', label = "Plancher")

#Names axis
plt.ylabel("Argent")

plt.legend()
plt.show()
